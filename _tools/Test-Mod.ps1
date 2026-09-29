<#
.SYNOPSIS
  Offline tests for Neck Accessory Renew: everything provable without a running game.

.DESCRIPTION
  Runs under Windows PowerShell 5.1. Reads the XML, the C# sources, the compiled assembly (as bytes)
  and the Pickle suite, and applies the vanilla-Disfigured patch to synthetic defs. Exits 1 when a
  check fails.

  What it does NOT prove: that a piece does anything on a map. That is Tests/Pickle/.
#>
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$mod = Join-Path $root 'Mod'
$failures = New-Object System.Collections.Generic.List[string]
$passed = 0

function Check([string]$name, [scriptblock]$body) {
    try {
        $problems = @(& $body)
        $problems = @($problems | Where-Object { $_ })
        if ($problems.Count -eq 0) { $script:passed++; Write-Host "  ok    $name" }
        else { foreach ($p in $problems) { $script:failures.Add("$name : $p") }; Write-Host "  FAIL  $name" -ForegroundColor Red; $problems | ForEach-Object { Write-Host "          $_" } }
    }
    catch { $script:failures.Add("$name : threw $($_.Exception.Message)"); Write-Host "  FAIL  $name (threw)" -ForegroundColor Red; Write-Host "          $($_.Exception.Message)" }
}

function Read-Xml([string]$path) { $d = New-Object System.Xml.XmlDocument; $d.PreserveWhitespace = $false; $d.Load($path); $d }
function Read-Text([string]$path) { [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8) }

$defFiles = Get-ChildItem (Join-Path $mod 'Defs') -Recurse -Filter *.xml
$defDocs = @{}
foreach ($f in $defFiles) { $defDocs[$f.FullName] = Read-Xml $f.FullName }
$ext = Read-Text (Join-Path $root 'Source\NeckAccessory\Extensions.cs')
$thoughtSrc = Read-Text (Join-Path $root 'Source\NeckAccessory\ThoughtWorkers.cs')
$dllBytes = [System.IO.File]::ReadAllBytes((Join-Path $mod 'Assemblies\NeckAccessory.dll'))
$dllText = [System.Text.Encoding]::ASCII.GetString($dllBytes)

$qualities = 'Awful', 'Poor', 'Normal', 'Good', 'Excellent', 'Masterwork', 'Legendary'
$vanillaHediffs = 'BadBack', 'Frail', 'Cataract'

Write-Host 'Well-formedness'
Check 'every distributed XML file parses' {
    Get-ChildItem $mod -Recurse -Include *.xml | ForEach-Object { try { [void](Read-Xml $_.FullName) } catch { "$($_.FullName): $($_.Exception.Message)" } }
}
Check 'no LoadFolders.xml and no modDependencies (the mod needs nothing beyond the game)' {
    if (Test-Path (Join-Path $mod 'LoadFolders.xml')) { 'LoadFolders.xml exists: the audit of dependencies must be redone' }
    $about = Read-Text (Join-Path $mod 'About\About.xml')
    if ($about -match '<modDependencies>') { 'About.xml declares modDependencies' }
}

Write-Host 'Classes named by the defs exist'
$extClasses = [regex]::Matches($ext, 'class\s+(\w+)\s*:\s*\w+') | ForEach-Object { $_.Groups[1].Value }
$thoughtClasses = [regex]::Matches($thoughtSrc, 'class\s+(\w+)\s*:\s*\w+') | ForEach-Object { $_.Groups[1].Value }
Check 'every modExtension class is in the sources and in the compiled assembly' {
    foreach ($doc in $defDocs.Values) {
        foreach ($li in $doc.SelectNodes('//modExtensions/li')) {
            $c = $li.GetAttribute('Class')
            if ($c -notmatch '^NeckAccessory\.(\w+)$') { "unexpected extension class '$c'"; continue }
            $short = $Matches[1]
            if ($extClasses -notcontains $short) { "$c is not declared in Extensions.cs" }
            if ($dllText.IndexOf($short) -lt 0) { "$c is not in the compiled assembly: rebuild Source/" }
        }
    }
}
Check 'every field an extension sets exists on its class' {
    foreach ($doc in $defDocs.Values) {
        foreach ($li in $doc.SelectNodes('//modExtensions/li')) {
            $short = $li.GetAttribute('Class') -replace '^NeckAccessory\.', ''
            $body = [regex]::Match($ext, "class\s+$short\s*:\s*\w+\s*\{(.*?)\n    \}", 'Singleline').Groups[1].Value
            $inherited = if ($short -eq 'NeckExtension') { '' } else { $ext }
            foreach ($child in $li.ChildNodes) {
                if ($child.NodeType -ne 'Element') { continue }
                $n = $child.Name
                if ($body -notmatch "\b$n\b" -and $ext -notmatch "abstract class NeckExtension[^}]*\b$n\b") { "$short has no field '$n'" }
            }
        }
    }
}
Check 'every worker and thing class named in the defs exists' {
    foreach ($doc in $defDocs.Values) {
        foreach ($n in $doc.SelectNodes('//workerClass|//thingClass')) {
            $t = $n.InnerText.Trim()
            if ($t -notmatch '^NeckAccessory\.(\w+)$') { continue }
            $short = $Matches[1]
            $known = $thoughtClasses + $extClasses + 'Building_SunLight'
            if ($known -notcontains $short) { "$t is not declared in the sources" }
            if ($dllText.IndexOf($short) -lt 0) { "$t is not in the compiled assembly" }
        }
    }
}

Write-Host 'Cross references'
$ownHediffs = @(); $ownThings = @(); $ownThoughts = @()
foreach ($doc in $defDocs.Values) {
    $ownHediffs += $doc.SelectNodes('//HediffDef/defName') | ForEach-Object { $_.InnerText }
    $ownThings += $doc.SelectNodes('//ThingDef/defName') | ForEach-Object { $_.InnerText }
    $ownThoughts += $doc.SelectNodes('//ThoughtDef/defName') | ForEach-Object { $_.InnerText }
}
Check 'every hediff a piece names is defined here or is a known vanilla one' {
    foreach ($doc in $defDocs.Values) {
        foreach ($n in $doc.SelectNodes('//erodeHediff|//affinityHediff|//extraHediff|//hediffToAdd|//recoverHediffs/li')) {
            $h = $n.InnerText.Trim()
            if ($ownHediffs -notcontains $h -and $vanillaHediffs -notcontains $h) { "hediff '$h' is neither defined here nor in the vanilla list" }
        }
    }
}
Check 'one sun light per quality, with a light that never shrinks as quality rises' {
    $last = -1
    foreach ($q in $qualities) {
        $name = "HDA_SunLight_$q"
        if ($ownThings -notcontains $name) { "$name is missing: Shine() looks it up by the quality name"; continue }
        $node = $defDocs.Values | ForEach-Object { $_.SelectSingleNode("//ThingDef[defName='$name']") } | Where-Object { $_ } | Select-Object -First 1
        $r = [double]$node.SelectSingleNode('comps/li/glowRadius').InnerText
        if ($r -lt $last) { "$name glows over $r cells, less than the quality below it ($last)" }
        $last = $r
    }
}
Check 'every default quality table has one entry per QualityCategory (7)' {
    foreach ($m in [regex]::Matches($ext, 'qualityFactors\s*=\s*new List<float>\s*\{([^}]*)\}')) {
        $n = ($m.Groups[1].Value -split ',').Count
        if ($n -ne 7) { "a qualityFactors default has $n entries" }
    }
    foreach ($doc in $defDocs.Values) { foreach ($q in $doc.SelectNodes('//qualityFactors')) { $n = $q.SelectNodes('li').Count; if ($n -ne 7) { "a qualityFactors in a def has $n entries" } } }
}
Check 'every piece sits on the mod''s own apparel layer' {
    $layer = @($defDocs.Values | ForEach-Object { $_.SelectNodes("//ApparelLayerDef/defName") } | ForEach-Object { $_.InnerText })
    if (-not $layer) { 'no ApparelLayerDef defined'; return }
    foreach ($doc in $defDocs.Values) {
        foreach ($t in $doc.SelectNodes("//ThingDef[starts-with(defName,'HDA_') and not(starts-with(defName,'HDA_SunLight'))]")) {
            $parent = $t.GetAttribute('ParentName')
            $own = $t.SelectNodes('apparel/layers/li') | ForEach-Object { $_.InnerText }
            $base = $doc.SelectSingleNode("//ThingDef[@Name='$parent']")
            $inherit = if ($base) { $base.SelectNodes('apparel/layers/li') | ForEach-Object { $_.InnerText } } else { @() }
            if (($own + $inherit) -notcontains $layer[0]) { "$($t.SelectSingleNode('defName').InnerText) is not on the layer $($layer[0])" }
        }
    }
}

Write-Host 'The Disfigured patch, applied to synthetic defs'
function Apply-DisfiguredPatch([string]$defsXml) {
    $doc = New-Object System.Xml.XmlDocument; $doc.LoadXml($defsXml)
    $patch = Read-Xml (Join-Path $mod 'Patches\Patches_Disfigured.xml')
    foreach ($op in $patch.SelectNodes('/Patch/Operation')) {
        $target = $doc.SelectNodes($op.SelectSingleNode('xpath').InnerText)
        foreach ($t in $target) {
            $cls = $op.GetAttribute('Class')
            $value = $op.SelectSingleNode('value')
            if ($cls -eq 'PatchOperationReplace') {
                $new = $doc.ImportNode($value.FirstChild, $true); [void]$t.ParentNode.ReplaceChild($new, $t)
            }
            elseif ($cls -eq 'PatchOperationAdd') {
                foreach ($c in $value.ChildNodes) { [void]$t.AppendChild($doc.ImportNode($c, $true)) }
            }
            else { throw "unknown operation $cls" }
        }
    }
    $doc
}
$vanilla = '<Defs><ThoughtDef><defName>Disfigured</defName><workerClass>ThoughtWorker_Disfigured</workerClass><stages><li><label>disfigured</label><baseOpinionOffset>-20</baseOpinionOffset></li></stages></ThoughtDef><ThoughtDef><defName>Other</defName><workerClass>ThoughtWorker_Other</workerClass><stages><li><label>other</label></li></stages></ThoughtDef></Defs>'
Check 'on the vanilla shape: worker replaced, one stage added, the original stage kept' {
    $d = Apply-DisfiguredPatch $vanilla
    $t = $d.SelectSingleNode('//ThoughtDef[defName="Disfigured"]')
    if ($t.SelectSingleNode('workerClass').InnerText -ne 'NeckAccessory.ThoughtWorker_Disfigured_ProofOfHero') { 'worker not replaced' }
    $labels = @($t.SelectNodes('stages/li/label') | ForEach-Object { $_.InnerText })
    if ($labels.Count -ne 2 -or $labels[0] -ne 'disfigured' -or $labels[1] -ne 'proof of hero') { "stages are: $($labels -join ' | ')" }
}
Check 'a stage another mod already added is kept' {
    $other = $vanilla -replace '</stages></ThoughtDef><ThoughtDef><defName>Other', '<li><label>from another mod</label></li></stages></ThoughtDef><ThoughtDef><defName>Other'
    $d = Apply-DisfiguredPatch $other
    $labels = @($d.SelectNodes('//ThoughtDef[defName="Disfigured"]/stages/li/label') | ForEach-Object { $_.InnerText })
    if ($labels.Count -ne 3 -or $labels -notcontains 'from another mod') { "stages are: $($labels -join ' | ')" }
}
Check 'no other thought is touched' {
    $d = Apply-DisfiguredPatch $vanilla
    $o = $d.SelectSingleNode('//ThoughtDef[defName="Other"]')
    if ($o.SelectSingleNode('workerClass').InnerText -ne 'ThoughtWorker_Other' -or $o.SelectNodes('stages/li').Count -ne 1) { 'the Other thought changed' }
}
Check 'the test can fail: a def without a Disfigured thought is left exactly as it was' {
    $d = Apply-DisfiguredPatch ($vanilla -replace 'Disfigured', 'Renamed')
    if ($d.OuterXml -match 'ProofOfHero') { 'the patch reached a thought that is not Disfigured' }
}
Check 'the worker the patch installs derives from the vanilla one and overrides the social state' {
    if ($thoughtSrc -notmatch 'class ThoughtWorker_Disfigured_ProofOfHero\s*:\s*ThoughtWorker_Disfigured') { 'not derived from ThoughtWorker_Disfigured' }
    if ($thoughtSrc -notmatch 'ProofOfHero[\s\S]*CurrentSocialStateInternal') { 'CurrentSocialStateInternal is not overridden' }
}

Write-Host 'Translations'
Check 'French injects the label of every owned ThingDef, HediffDef and ThoughtDef that has one' {
    $fr = Get-ChildItem (Join-Path $mod 'Languages\French') -Recurse -Filter *.xml | ForEach-Object { Read-Text $_.FullName } | Out-String
    foreach ($doc in $defDocs.Values) {
        foreach ($d in $doc.SelectNodes('//ThingDef[defName and label]|//HediffDef[defName and label]|//ThoughtDef[defName and label]')) {
            $n = $d.SelectSingleNode('defName').InnerText
            if ($fr -notmatch "<$([regex]::Escape($n))\.label>") { "$n has no French label" }
        }
    }
}
Check 'French injects the description of every owned ThingDef that has one' {
    $fr = Get-ChildItem (Join-Path $mod 'Languages\French') -Recurse -Filter *.xml | ForEach-Object { Read-Text $_.FullName } | Out-String
    foreach ($doc in $defDocs.Values) {
        foreach ($d in $doc.SelectNodes('//ThingDef[defName and description]')) {
            $n = $d.SelectSingleNode('defName').InnerText
            if ($fr -notmatch "<$([regex]::Escape($n))\.description>") { "$n has no French description" }
        }
    }
}
Check 'French leaves no untranslated placeholder' {
    Get-ChildItem (Join-Path $mod 'Languages\French') -Recurse -Filter *.xml | ForEach-Object {
        $t = Read-Text $_.FullName
        if ($t -match 'TODO|NEEDS_TRANSLATION|\{\d+\}') { "$($_.Name) holds a placeholder" }
    }
}

Write-Host 'Metadata and packaging'
Check 'About: packageId, source link last, unofficial notice first' {
    $a = Read-Xml (Join-Path $mod 'About\About.xml')
    if ($a.ModMetaData.packageId -ne 'nelim.neckaccessory') { "packageId is $($a.ModMetaData.packageId): it is frozen" }
    $d = $a.ModMetaData.description.Trim()
    if (-not $d.EndsWith('[url=https://github.com/vbardales/Rimworld-Neck-Accessory]Source code on GitHub[/url]')) { 'the description does not end with the Source code link' }
    if (-not $d.StartsWith('UNOFFICIAL.')) { 'the description does not start with the unofficial notice' }
    if ($a.ModMetaData.name -notmatch '\(unofficial\)$') { 'the name does not end with (unofficial)' }
}
Check 'images: Preview under 1 MB, 16:9; ModIcon 128 px' {
    function Png-Size($p) { $b = [System.IO.File]::ReadAllBytes($p); $w = ($b[16] * 16777216) + ($b[17] * 65536) + ($b[18] * 256) + $b[19]; $h = ($b[20] * 16777216) + ($b[21] * 65536) + ($b[22] * 256) + $b[23]; "$w x $h" }
    $p = Join-Path $mod 'About\Preview.png'
    if ((Get-Item $p).Length -ge 1MB) { 'Preview.png is 1 MB or more' }
    if ((Png-Size $p) -ne '896 x 504') { "Preview.png is $(Png-Size $p)" }
    if ((Png-Size (Join-Path $mod 'About\ModIcon.png')) -ne '128 x 128') { 'ModIcon.png is not 128 x 128' }
}
Check 'the distributed copies of LICENSE and ATTRIBUTION are identical to the root ones' {
    foreach ($f in 'LICENSE', 'ATTRIBUTION.md') {
        if ((Get-FileHash (Join-Path $root $f)).Hash -ne (Get-FileHash (Join-Path $mod $f)).Hash) { "Mod/$f differs from $f" }
    }
}
Check 'nothing that must stay out of Mod/ is in it' {
    Get-ChildItem $mod -Recurse -Force | Where-Object { $_.Name -match '^(STATUS\.md|CHANGELOG\.md|README\.md|.*\.ico|.*\.pdb|.*\.dds)$' -and $_.Name -ne 'desktop.ini' } | ForEach-Object { "$($_.FullName) must not ship" }
}

Write-Host 'The Pickle suite'
$suite = Join-Path $root 'Tests\Pickle'
Check 'every Neck Accessory step used by a feature is defined by the steps assembly source' {
    $src = Read-Text (Join-Path $suite 'Source\NeckAccessorySteps.cs')
    $patterns = [regex]::Matches($src, '\[(?:Given|When|Then)\("([^"]+)"') | ForEach-Object {
        $e = [regex]::Escape($_.Groups[1].Value)
        $e = $e -replace '\\\{string\}', '"[^"]*"' -replace '\\\{int\}', '-?\d+' -replace '\\\{float\}', '-?\d+(\.\d+)?'
        "^$e$"
    }
    $lines = Get-ChildItem (Join-Path $suite 'Mod\Pickle\Features') -Filter *.feature | ForEach-Object { Get-Content $_.FullName | ForEach-Object { $_ } }
    foreach ($l in $lines) {
        if ($l -match '^\s*(?:Given|When|Then|And)\s+(Neck Accessory:.*)$') {
            $step = $Matches[1].Trim()
            $ok = $false; foreach ($p in $patterns) { if ($step -match $p) { $ok = $true; break } }
            if (-not $ok) { "undefined step: $step" }
        }
    }
}
Check 'no scenario is tagged @wip' {
    Get-ChildItem (Join-Path $suite 'Mod\Pickle\Features') -Filter *.feature | Select-String -Pattern '@wip' | ForEach-Object { "@wip in $($_.Filename):$($_.LineNumber)" }
}
Check 'the companion is not inside Mod/ and names its dependencies' {
    $a = Read-Xml (Join-Path $suite 'Mod\About\About.xml')
    if ($a.ModMetaData.packageId -ne 'nelim.neckaccessory.pickletests') { 'unexpected companion packageId' }
    $deps = @($a.SelectNodes('//modDependencies/li/packageId') | ForEach-Object { $_.InnerText })
    if ($deps -notcontains 'nelim.neckaccessory' -or $deps -notcontains 'rimworks.pickle') { 'the companion must depend on the mod and on Pickle' }
}

Write-Host ''
Write-Host "$passed passed, $($failures.Count) failed"
if ($failures.Count -gt 0) { exit 1 }
