param([Parameter(Mandatory)][string]$ModRoot, [string]$SharedDir)

# Own values and facts of this mod: one sun light per quality, the 7-entry quality tables, the mod's apparel layer, no dependencies,
# the Disfigured patch applied to synthetic defs, the packageId and the description ends, the gallery copy of the Preview, no @wip
# and the Pickle companion identity. One consumer, nothing shareable; Tests/Test-Mod.ps1 (generated) runs it after the shared checks.
# Prints findings, exit 1 on any.
# Left to the shared checks: XML parse, defNames, class, field and def references (Check-ModBasics, Check-DefRefs, Check-TypeRefs,
# Check-XmlFields), About shape, "(unofficial)" and image sizes (Check-ModBasics), forbidden files in Mod/ (Check-ModBasics),
# French coverage (Check-Translations, Check-DefInjected), step resolution (Check-Steps).
# The Disfigured patch needs the shared interpreter $SharedDir/lib/PatchEngine.ps1: without -SharedDir those rules are skipped loudly.
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ModRoot).Path
$mod = Join-Path $root 'Mod'
$script:findings = @()

# One rule: the block returns its problems; each is printed under the rule name.
function It([string]$name, [scriptblock]$body) {
    try { $problems = @(& $body | Where-Object { $_ }) } catch { $problems = @("threw: $($_.Exception.GetBaseException().Message)") }
    foreach ($p in $problems) { $script:findings += "[$name] $p" }
}
function Read-Xml([string]$path) { $d = New-Object System.Xml.XmlDocument; $d.PreserveWhitespace = $false; $d.Load($path); $d }
function Read-Text([string]$path) { [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8) }

$defDocs = @{}
foreach ($f in (Get-ChildItem (Join-Path $mod 'Defs') -Recurse -Filter *.xml)) { $defDocs[$f.FullName] = Read-Xml $f.FullName }
$ext = Read-Text (Join-Path $root 'Source\NeckAccessory\Extensions.cs')
$thoughtSrc = Read-Text (Join-Path $root 'Source\NeckAccessory\ThoughtWorkers.cs')
$qualities = 'Awful', 'Poor', 'Normal', 'Good', 'Excellent', 'Masterwork', 'Legendary'

It 'No LoadFolders.xml and no modDependencies: redo the dependency audit if one appears' {
    if (Test-Path (Join-Path $mod 'LoadFolders.xml')) { 'LoadFolders.xml exists' }
    if ((Read-Text (Join-Path $mod 'About\About.xml')) -match '<modDependencies>') { 'About.xml declares modDependencies' }
}

$ownThings = @()
foreach ($doc in $defDocs.Values) { $ownThings += $doc.SelectNodes('//ThingDef/defName') | ForEach-Object { $_.InnerText } }
It 'One sun light per quality, with a light that never shrinks as quality rises' {
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
It 'Every default quality table has one entry per QualityCategory (7)' {
    foreach ($m in [regex]::Matches($ext, 'qualityFactors\s*=\s*new List<float>\s*\{([^}]*)\}')) {
        $n = ($m.Groups[1].Value -split ',').Count
        if ($n -ne 7) { "a qualityFactors default has $n entries" }
    }
    foreach ($doc in $defDocs.Values) { foreach ($q in $doc.SelectNodes('//qualityFactors')) { $n = $q.SelectNodes('li').Count; if ($n -ne 7) { "a qualityFactors in a def has $n entries" } } }
}
It 'Every piece sits on the mod''s own apparel layer' {
    $layer = @($defDocs.Values | ForEach-Object { $_.SelectNodes('//ApparelLayerDef/defName') } | ForEach-Object { $_.InnerText })
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

$engine = if ($SharedDir) { Join-Path $SharedDir 'lib\PatchEngine.ps1' }
if ($engine -and (Test-Path -LiteralPath $engine)) {
    . $engine
    function Apply-DisfiguredPatch([string]$defsXml) {
        $doc = New-Object System.Xml.XmlDocument; $doc.LoadXml($defsXml)
        $patch = Read-Xml (Join-Path $mod 'Patches\Patches_Disfigured.xml')
        foreach ($op in $patch.SelectNodes('/Patch/Operation')) { Invoke-PatchOperation $op $doc }
        $doc
    }
    $vanilla = '<Defs><ThoughtDef><defName>Disfigured</defName><workerClass>ThoughtWorker_Disfigured</workerClass><stages><li><label>disfigured</label><baseOpinionOffset>-20</baseOpinionOffset></li></stages></ThoughtDef><ThoughtDef><defName>Other</defName><workerClass>ThoughtWorker_Other</workerClass><stages><li><label>other</label></li></stages></ThoughtDef></Defs>'
    It 'Disfigured patch on the vanilla shape: worker replaced, one stage added, the original stage kept' {
        $d = Apply-DisfiguredPatch $vanilla
        $t = $d.SelectSingleNode('//ThoughtDef[defName="Disfigured"]')
        if ($t.SelectSingleNode('workerClass').InnerText -ne 'NeckAccessory.ThoughtWorker_Disfigured_ProofOfHero') { 'worker not replaced' }
        $labels = @($t.SelectNodes('stages/li/label') | ForEach-Object { $_.InnerText })
        if ($labels.Count -ne 2 -or $labels[0] -ne 'disfigured' -or $labels[1] -ne 'proof of hero') { "stages are: $($labels -join ' | ')" }
    }
    It 'Disfigured patch keeps a stage another mod already added' {
        $other = $vanilla -replace '</stages></ThoughtDef><ThoughtDef><defName>Other', '<li><label>from another mod</label></li></stages></ThoughtDef><ThoughtDef><defName>Other'
        $d = Apply-DisfiguredPatch $other
        $labels = @($d.SelectNodes('//ThoughtDef[defName="Disfigured"]/stages/li/label') | ForEach-Object { $_.InnerText })
        if ($labels.Count -ne 3 -or $labels -notcontains 'from another mod') { "stages are: $($labels -join ' | ')" }
    }
    It 'Disfigured patch touches no other thought' {
        $d = Apply-DisfiguredPatch $vanilla
        $o = $d.SelectSingleNode('//ThoughtDef[defName="Other"]')
        if ($o.SelectSingleNode('workerClass').InnerText -ne 'ThoughtWorker_Other' -or $o.SelectNodes('stages/li').Count -ne 1) { 'the Other thought changed' }
    }
    It 'Disfigured patch leaves a def without a Disfigured thought exactly as it was' {
        $d = Apply-DisfiguredPatch ($vanilla -replace 'Disfigured', 'Renamed')
        if ($d.OuterXml -match 'ProofOfHero') { 'the patch reached a thought that is not Disfigured' }
    }
}
else {
    Write-Host 'SKIP  Disfigured patch rules: no -SharedDir with lib/PatchEngine.ps1 (run them where the protocols repository is checked out)'
}
It 'The worker the patch installs derives from the vanilla one and overrides the social state' {
    if ($thoughtSrc -notmatch 'class ThoughtWorker_Disfigured_ProofOfHero\s*:\s*ThoughtWorker_Disfigured') { 'not derived from ThoughtWorker_Disfigured' }
    if ($thoughtSrc -notmatch 'ProofOfHero[\s\S]*CurrentSocialStateInternal') { 'CurrentSocialStateInternal is not overridden' }
}

It 'About: packageId frozen, source link last, unofficial notice first' {
    $a = Read-Xml (Join-Path $mod 'About\About.xml')
    if ($a.ModMetaData.packageId -ne 'nelim.neckaccessory') { "packageId is $($a.ModMetaData.packageId): it is frozen" }
    $d = $a.ModMetaData.description.Trim()
    if (-not $d.EndsWith('[url=https://github.com/vbardales/Rimworld-Neck-Accessory]Source code on GitHub[/url]')) { 'the description does not end with the Source code link' }
    if (-not $d.StartsWith('UNOFFICIAL.')) { 'the description does not start with the unofficial notice' }
}
It 'The gallery starts with a byte-for-byte copy of the Preview (Art/Gallery/0-preview.png)' {
    $g = Join-Path $root 'Art\Gallery\0-preview.png'
    if (-not (Test-Path $g)) { 'Art/Gallery/0-preview.png is missing'; return }
    if ((Get-FileHash $g).Hash -ne (Get-FileHash (Join-Path $mod 'About\Preview.png')).Hash) { '0-preview.png differs from Mod/About/Preview.png: recopy it' }
}

$suite = Join-Path $root 'Tests\Pickle'
It 'No scenario is tagged @wip' {
    Get-ChildItem (Join-Path $suite 'Mod\Pickle\Features') -Filter *.feature | Select-String -Pattern '@wip' | ForEach-Object { "@wip in $($_.Filename):$($_.LineNumber)" }
}
It 'The companion names its dependencies' {
    $a = Read-Xml (Join-Path $suite 'Mod\About\About.xml')
    if ($a.ModMetaData.packageId -ne 'nelim.neckaccessory.pickletests') { 'unexpected companion packageId' }
    $deps = @($a.SelectNodes('//modDependencies/li/packageId') | ForEach-Object { $_.InnerText })
    if ($deps -notcontains 'nelim.neckaccessory' -or $deps -notcontains 'rimworks.pickle') { 'the companion must depend on the mod and on Pickle' }
}

if ($script:findings.Count -gt 0) { $script:findings | ForEach-Object { Write-Host $_ }; exit 1 }
Write-Host 'Rule-OwnValues: all rules pass'
exit 0
