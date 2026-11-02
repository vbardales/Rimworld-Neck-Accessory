<#
.SYNOPSIS
  Offline tests for Neck Accessory Renew: the values and behaviours of this mod that no shared check knows.

.DESCRIPTION
  Runs under Windows PowerShell 5.1. Exits 1 when a check fails.

  Not here, because the shared checks of the protocols repository already do it for any mod
  (run them first, see TESTING.md): XML well-formedness, duplicate defNames, defs and types named by
  the XML (Check-ModBasics, Check-DefRefs, Check-TypeRefs), element-to-field mapping including the
  mod's own extension classes (Check-XmlFields with -ExtraAssemblies), French coverage, stale keys
  and placeholders (Check-Translations, Check-DefInjected), step resolution (Check-Steps), LICENSE and
  ATTRIBUTION copies (Check-ModBasics).

  What it does NOT prove: that a piece does anything on a map. That is Tests/Pickle/.
#>
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$mod = Join-Path $root 'Mod'
$failures = New-Object System.Collections.Generic.List[string]
$passed = 0

# Vendored copy of the shared interpreter of PatchOperations (written only by scripts/Sync-PatchEngine.ps1).
. (Join-Path $PSScriptRoot 'lib\PatchEngine.ps1')

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

$defDocs = @{}
foreach ($f in (Get-ChildItem (Join-Path $mod 'Defs') -Recurse -Filter *.xml)) { $defDocs[$f.FullName] = Read-Xml $f.FullName }
$ext = Read-Text (Join-Path $root 'Source\NeckAccessory\Extensions.cs')
$thoughtSrc = Read-Text (Join-Path $root 'Source\NeckAccessory\ThoughtWorkers.cs')
$qualities = 'Awful', 'Poor', 'Normal', 'Good', 'Excellent', 'Masterwork', 'Legendary'

Write-Host 'The mod needs nothing beyond the game'
Check 'no LoadFolders.xml and no modDependencies: the audit of dependencies must be redone if one appears' {
    if (Test-Path (Join-Path $mod 'LoadFolders.xml')) { 'LoadFolders.xml exists' }
    if ((Read-Text (Join-Path $mod 'About\About.xml')) -match '<modDependencies>') { 'About.xml declares modDependencies' }
}

Write-Host 'Values of the defs'
$ownThings = @()
foreach ($doc in $defDocs.Values) { $ownThings += $doc.SelectNodes('//ThingDef/defName') | ForEach-Object { $_.InnerText } }
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
    foreach ($op in $patch.SelectNodes('/Patch/Operation')) { Invoke-PatchOperation $op $doc }
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

Write-Host 'Identity and packaging of this mod'
Check 'About: packageId frozen, source link last, unofficial notice first' {
    $a = Read-Xml (Join-Path $mod 'About\About.xml')
    if ($a.ModMetaData.packageId -ne 'nelim.neckaccessory') { "packageId is $($a.ModMetaData.packageId): it is frozen" }
    $d = $a.ModMetaData.description.Trim()
    if (-not $d.EndsWith('[url=https://github.com/vbardales/Rimworld-Neck-Accessory]Source code on GitHub[/url]')) { 'the description does not end with the Source code link' }
    if (-not $d.StartsWith('UNOFFICIAL.')) { 'the description does not start with the unofficial notice' }
    if ($a.ModMetaData.name -notmatch '\(unofficial\)$') { 'the name does not end with (unofficial)' }
}
Check 'images: Preview 896 x 504, ModIcon 128 x 128' {
    function Png-Size($p) { $b = [System.IO.File]::ReadAllBytes($p); $w = ($b[16] * 16777216) + ($b[17] * 65536) + ($b[18] * 256) + $b[19]; $h = ($b[20] * 16777216) + ($b[21] * 65536) + ($b[22] * 256) + $b[23]; "$w x $h" }
    if ((Png-Size (Join-Path $mod 'About\Preview.png')) -ne '896 x 504') { 'Preview.png is not 896 x 504' }
    if ((Png-Size (Join-Path $mod 'About\ModIcon.png')) -ne '128 x 128') { 'ModIcon.png is not 128 x 128' }
}
Check 'the gallery starts with a byte-for-byte copy of the Preview (Art/Gallery/0-preview.png)' {
    $g = Join-Path $root 'Art\Gallery\0-preview.png'
    if (-not (Test-Path $g)) { 'Art/Gallery/0-preview.png is missing'; return }
    if ((Get-FileHash $g).Hash -ne (Get-FileHash (Join-Path $mod 'About\Preview.png')).Hash) { '0-preview.png differs from Mod/About/Preview.png: recopy it' }
}
Check 'nothing that must stay out of Mod/ is in it' {
    Get-ChildItem $mod -Recurse -Force | Where-Object { $_.Name -match '^(STATUS\.md|CHANGELOG\.md|README\.md|.*\.ico|.*\.pdb|.*\.dds)$' -and $_.Name -ne 'desktop.ini' } | ForEach-Object { "$($_.FullName) must not ship" }
}

Write-Host 'The Pickle suite'
$suite = Join-Path $root 'Tests\Pickle'
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
