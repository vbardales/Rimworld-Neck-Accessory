<#
.SYNOPSIS
  Builds FRENCH_REVIEW.md from the shipped French DefInjected XML (TRANSLATIONS.md, "Systematic
  French review by Virginie"). Windows PowerShell 5.1.
.DESCRIPTION
  One table per French file, one row per key, in the shipped order. English is read from the
  shipped Def (Mod/Defs) or, for the stage this mod adds to the vanilla Disfigured thought, from
  Mod/Patches. Stage keys use the handle scheme of the game (label without punctuation, spaces to
  underscores, duplicates suffixed -0, -1...). The mod has no Keyed file and no grammar file.
  Doubts about a French text go in $doubts below, one line each: they become the fifth column.
#>
param(
    [string]$Root = (Split-Path $PSScriptRoot -Parent),
    [string]$OutFile = (Join-Path (Split-Path $PSScriptRoot -Parent) 'FRENCH_REVIEW.md')
)

$doubts = @{
    'HDA_Heros_scarf.description' = 'Reworded to avoid a masculine that would refer to any wearer ("le voir", "ceux qui le regardent"); no longer names the hero.'
    'HDA_Hediff_Hero_inspirationt.stages.I_do_not_feel_like_losing_as_long_as_there_are_heroes.label' = 'Reworded ("il" referred to the wearer, any gender); "héros" is now generic and plural.'
    'HeroIsOnlyOne.stages.hero_is_only_one.label' = '"héros" is masculine and names the wearer of the other scarf, of any gender: keep, or rework?'
    'HDA_Heros_scarf.label' = '"héros" in an item name; there is no feminine form of the scarf. Keep?'
    'HDA_Hediff_Hero_inspirationt.label' = '"héros" in a hediff name, same question.'
    'RoseNecklace.stages.nice_guy-0.label' = 'Rose necklace is worn by a man (the description says so), so the masculine is fixed, not an agreement.'
    'RoseNecklace.stages.nice_guy-1.label' = 'Same: the masculine names the wearer, a man.'
    'LilyNecklace.stages.nice_lady-0.label' = 'Lily necklace is worn by a woman: the feminine is fixed.'
    'LilyNecklace.stages.nice_lady-1.label' = 'Same, and identical to stage 0 as in the original.'
    'HDA_RoseNecklace.description' = '"son propre sexe" is a wording chosen to avoid a gender switch; the trait it grants is not announced.'
    'HDA_LilyNecklace.description' = 'Same as the rose necklace.'
    'InvitationForForbiddance.stages.A_gaze_from_homosexuality_is_comfortable-0.label' = 'Reworded from "homosexuality" to "son propre sexe"; the three stages share one text as in English.'
}

function Get-Entries($path) {
    $entries = New-Object System.Collections.Specialized.OrderedDictionary
    $xml = New-Object System.Xml.XmlDocument
    $xml.Load($path)
    foreach ($node in $xml.DocumentElement.ChildNodes) {
        if ($node.NodeType -ne 'Element') { continue }
        $entries.Add($node.Name, $node.InnerText)
    }
    return $entries
}

function Get-Handle($label) {
    return ((($label -replace '[^\p{L}\p{N} \-]', '').Trim()) -replace ' ', '_')
}

# Handle of every stage <li> of a stages node, dupes suffixed -0, -1...
function Get-StageMap($stagesNode) {
    $lis = @($stagesNode.ChildNodes | Where-Object { $_.NodeType -eq 'Element' })
    $handles = @($lis | ForEach-Object { Get-Handle ($_.SelectSingleNode('label').InnerText) })
    $map = @{}
    for ($i = 0; $i -lt $lis.Count; $i++) {
        $n = @($handles | Where-Object { $_ -eq $handles[$i] }).Count
        $h = $handles[$i]
        if ($n -gt 1) { $h = $h + '-' + (@($handles[0..$i] | Where-Object { $_ -eq $handles[$i] }).Count - 1).ToString() }
        $map[$h] = $lis[$i]
    }
    return $map
}

function Resolve-English($defDocs, $patchDocs, [string]$key) {
    $parts = $key -split '\.'
    $defName = $parts[0]
    foreach ($doc in $defDocs) {
        $def = $doc.SelectSingleNode("//*[defName='$defName']")
        if (-not $def) { continue }
        $rest = $parts[1..($parts.Length - 1)]
        if ($rest[0] -eq 'stages') {
            $st = Get-StageMap $def.SelectSingleNode('stages')
            $hit = $st[$rest[1]]
            if ($hit) { $n = $hit.SelectSingleNode($rest[2]); if ($n) { return $n.InnerText } }
        } else {
            $n = $def.SelectSingleNode($rest[0])
            if ($n) { return $n.InnerText }
        }
    }
    # A stage the mod adds to a vanilla def through a patch.
    if ($parts[1] -eq 'stages') {
        foreach ($doc in $patchDocs) {
            foreach ($stages in $doc.SelectNodes('//value')) {
                $st = Get-StageMap $stages
                $hit = $st[$parts[2]]
                if ($hit) { $n = $hit.SelectSingleNode($parts[3]); if ($n) { return $n.InnerText } }
            }
        }
    }
    return $null
}

function Load-Docs($dir) {
    $docs = @()
    foreach ($f in Get-ChildItem $dir -Recurse -Filter *.xml) {
        $d = New-Object System.Xml.XmlDocument
        $d.Load($f.FullName)
        $docs += $d
    }
    return $docs
}

$defDocs = Load-Docs (Join-Path $Root 'Mod/Defs')
$patchDocs = Load-Docs (Join-Path $Root 'Mod/Patches')
$frenchRoot = Join-Path $Root 'Mod/Languages/French'
$rev = (& git -C $Root rev-parse --short HEAD).Trim()
$dirty = if ((& git -C $Root status --porcelain -- Mod).Length -gt 0) { ' + uncommitted changes under Mod/' } else { '' }

$out = New-Object System.Text.StringBuilder
[void]$out.AppendLine('# French review: Neck Accessory Renew')
[void]$out.AppendLine()
[void]$out.AppendLine('Generated by `_tools/Generate-FrenchReview.ps1` from the shipped XML. Revision: `' + $rev + '`' + $dirty + '.')
[void]$out.AppendLine()
[void]$out.AppendLine('**Original column: same as English throughout.** The mod was ported from a Japanese original whose')
[void]$out.AppendLine('texts are not stored in this repository as data; only the ported English and the French remain.')
[void]$out.AppendLine('The mod has no Keyed file and no grammar file, only DefInjected. The `?` column carries a doubt.')
[void]$out.AppendLine()
[void]$out.AppendLine('Gender agreement: no French text of this mod agrees with a pawn through a switch. The texts that name')
[void]$out.AppendLine('a pawn were reworded to carry no agreement, or name a fixed sex (rose necklace: a man; lily: a woman).')
[void]$out.AppendLine()

foreach ($ff in (Get-ChildItem $frenchRoot -Recurse -Filter *.xml | Sort-Object FullName)) {
    $rel = $ff.FullName.Substring($frenchRoot.Length + 1) -replace '\\', '/'
    $entries = Get-Entries $ff.FullName
    if ($entries.Count -eq 0) { continue }
    [void]$out.AppendLine("## $rel")
    [void]$out.AppendLine()
    [void]$out.AppendLine('| Key or path | Original | English | French | ? |')
    [void]$out.AppendLine('|---|---|---|---|---|')
    foreach ($key in $entries.Keys) {
        $en = Resolve-English $defDocs $patchDocs $key
        if ($null -eq $en) { $en = '*(not found: check by hand)*' }
        $cell = { param($t) (($t -replace '\|', '\|') -replace "`r?`n", ' ') }
        $flag = ''
        if ($doubts.ContainsKey($key)) { $flag = '? ' + $doubts[$key] }
        [void]$out.AppendLine('| ' + $key + ' | ' + (& $cell $en) + ' | ' + (& $cell $en) + ' | ' + (& $cell $entries[$key]) + ' | ' + $flag + ' |')
    }
    [void]$out.AppendLine()
}

[System.IO.File]::WriteAllText($OutFile, $out.ToString(), (New-Object System.Text.UTF8Encoding($false)))
Write-Output "wrote $OutFile"
