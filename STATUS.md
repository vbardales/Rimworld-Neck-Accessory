---
localization: complete
translation_en: complete
translation_fr: partial
mod:          Neck Accessory Renew (unofficial)
packageId:    nelim.neckaccessory
repo:         Rimworld-Neck-Accessory
visibility:   public
detached:     yes
stage:        done
workflow_stage: l10n
settings_audit: not_applicable
licence:      silent
licence_at:   ATTRIBUTION.md, upstream review 2026-09-13
upstream_mod_remotes:
  - N/A
dependencies: none
showcase:     partial
tested_on:
workshop:
remaining:
  - unverified: French review by Virginie (FRENCH_REVIEW.md, revision named there)
  - unverified: whether the sunlight objects are exposed in any game UI (mouse-over, inspect)
  - unverified: the Pickle suite (Tests/Pickle, 15 scenarios + 8-piece outline) has never been played; two passes, English and French, are the criteria of done -> tested
  - unverified: which stage the hero scarf gives the Disfigured thought (no scenario, see TESTING.md)
  - unverified: in-game EN/FR UI, logs, new game and existing save
  - unverified: current upstream permission and supported-version evidence (Steam page 1611488293 not rechecked)
session:      maj:        2026-09-12, releve automatique
updated:      2026-09-29, tests written
---

## Audit — 2026-09-29

Previous stage: `Preview générée` (a label, not one of the six `stage` codes). Retained:
`stage: showcase`, `workflow_stage: options`. Revision audited: `e0c80b7` plus the local changes below.

| Transition | Result |
| --- | --- |
| dansMonoRepo -> horsMonoRepo | Passed. The folder was a stale copy inside the monorepo (4 tracked files); it is now the standalone checkout of `vbardales/Rimworld-Neck-Accessory`, `main` = `origin/main`, and it is untracked and ignored by the monorepo. Public repo, STATUS/README/ATTRIBUTION/LICENSE/CHANGELOG present, `ATTRIBUTION.md` and `LICENSE` identical to their `Mod/` copies (cmp). |
| -> ModIcon | Passed as of 2026-09-13 (128x128 PNG, 15,268 bytes; the owner chose the necklace-only icon over the mascot). Not regenerated. |
| -> Preview | Passed: `Mod/About/Preview.png`, 896x504 PNG, 708 KB, opened and looked at. |
| -> preOptions | Passed after this audit: the description now ends with `[url=https://github.com/vbardales/Rimworld-Neck-Accessory]Source code on GitHub[/url]` (the defect of 2026-09-13). The Preview accents (gold, steel, crimson on dark wood) are distinct. |
| -> options | Passed: `settings_audit: not_applicable`, see the 2026-09-13 section below (no settings page, no shortcut). |
| -> l10n | **Passed on 2026-09-29** (replaces the failure below): French injections added for the seven `HDA_SunLight_*` defs (14 fields, label "lumière du soleil", description "Une lumière du jour."), `Check-DefInjected.ps1`: 148 keys, 0 errors. In-game exposure of these objects stays unverified. Earlier finding: seven `HDA_SunLight_*` defs have English label/description and no French injection. Whether they can be seen in game is not known. |
| -> preTest | Passed on the 2026-09-13 checks (not redone). Dependencies were checked on 2026-09-13 (none; no LoadFolders); not redone here. |
| -> done | Not reached: no scenarios, no automated tests, no Pickle suite, no justification written. |
| -> tested | Not reached; the game was not launched. |

Other checks done today: no `.dds` file exists in the tree or in git (the ignore rule was added anyway);
no Pickle evidence exists; no `PublishedFileId.txt` exists, so the item is not pre-published and
`CHANGELOG.md` keeps `1.0.0 — unreleased` (write `0.1.0` — "creation of a publishIdFile" once the file appears).
Upstream: Udon's mod lives only on the Steam Workshop (1611488293); no git repository was found, so
`upstream_mod_remotes` is `N/A` and there is no repository to send pull requests to.

## Tests written — 2026-09-29

Stage `done` (`preTest -> done`): offline suite `_tools/Test-Mod.ps1` run and green (24 checks, Windows PowerShell 5.1,
plus a negative control on the Disfigured patch); Pickle suite written (`Tests/Pickle/`: 3 features, a steps assembly that
compiles with 0 errors, no scenario tagged `@wip`); functional scenarios with preconditions, actions and expected results,
and the pass matrix, are in `TESTING.md`. No optional mod, no incompatibility and no DLC-absent pass applies, each with its
reason there. Manual tests: none. **The Pickle suite has not been played**, which is not a criterion of `done`.
Supersedes the "not reached" rows of the 2026-09-29 audit table for `preTest -> done`.

## Preview and gallery — 2026-09-29

New showcase rules: the Preview carries the ModIcon cut out of its background in a corner (left +15deg, right -15deg), and the
gallery starts with `00-`, a byte-for-byte copy of the Preview. `Mod/About/Preview.png` is now `Art/Preview-before-icon.png` plus the
cut-out icon, bottom-left, +15deg (`_tools/compose-preview.cjs`, opened and looked at: 896x504, 733,625 bytes). `Art/Workshop/00-preview.png`
is its copy; the offline suite checks that they stay identical (25 checks green). No capture exists yet, so the gallery is one image.
This changed `Mod/About/Preview.png` after the two Pickle tickets were filed at `c004fae`: it does not touch what those tickets test.

### What `done -> tested` will need (2026-09-29 criteria)

- No scenario tagged `@wip`: repaired and replayed, or deleted with the reason.
- Every conditional scenario (`@requires:<packageId>`) has run, with its report read. There is no optional mod today.
- No manual test left to validate: each one is automated and green, or listed as not applicable with its reason.
- `@review` captures opened and looked at.

### Evidence to keep

Evidence stays on disk, never in git: `Tests/Pickle/Evidence/`, `Tests/Pickle/results/` and `evidence/` are in `.gitignore`
(as is `*.dds`). Keep, per scenario, the newest report for the revision now in the repository, plus an older one only if it
is the sole proof of a check the newest did not repeat. Screenshots may be minified. One text line per run goes in
`docs/runs/`. Never delete a report a `STATUS.md` field points to; repoint first.

### Next work, in order

1. The in-game passes (via `Submit-PickleRun.ps1`; never launch the game directly).

# Neck Accessory Renew (unofficial) — status

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`** — one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`** — the date of the last run in game. Empty means never.
- **`dependencies`** — `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`** — what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.

## Rename — 2026-09-13

- Display name: Neck Accessory Renew (unofficial).
- Project folder: NeckAccessoryRenew (previously NeckAccessory).
- Package ID, Def names, assembly and source namespaces remain unchanged for compatibility.
- Existing repository URLs are retained; no remote repository rename or publication performed.
- Naming-only change; workflow stage and unverified validation fields remain unchanged.

## Workflow audit — 2026-09-13

### Scope and revision

Previous stage: empty (the historical showcase field said complete). Retained stage:
`dansMonoRepo`, using the exact workflow label, not a legacy stage code.
Project: `C:/Users/nelim/Documents/rimworld/NeckAccessoryRenew`; distributed root: `Mod/`.
`git rev-parse --show-toplevel` resolves to the parent RimWorld monorepo, not this project.
Monorepo HEAD observed: `75c3000e1833d325cc7626a402981e4aa881d47a`.
The renamed project is untracked (`?? ./`); the preceding rename changed About.xml,
README.md and STATUS.md and preserved internal identifiers. Existing local changes were retained.
This audit changes only STATUS.md; build output was redirected to the temporary directory.
No game launch, publication, repository creation or feature implementation was performed.
The empty old project directory remains present after the Windows rename lock.

### Ordered transition results

| Transition | Result and evidence |
| --- | --- |
| dansMonoRepo -> horsMonoRepo | Blocked: this working copy has no autonomous Git repository and remains inside the monorepo. The existing GitHub repository `vbardales/Rimworld-Neck-Accessory` is PUBLIC with main commit `da7e9125ab75f8ec8c2b7f97335b9b05c10da486`, verified with gh. Remote existence is therefore validated; the missing autonomous checkout is a separate unmet criterion. |
| horsMonoRepo -> ModIcon generated | Independent build and DLL freshness checks passed. Icon is a valid 128x128 PNG, 15,268 bytes. Direct inspection shows a gold necklace on black, without the mascot required by the current icon style; style conformity is not validated. Overall transition cannot pass earlier gates. |
| ModIcon generated -> Preview generated | Defect: `Mod/About/Preview.png` is absent. The directly inspected `Art/Preview-source.png` is a 512x512, 29,629-byte rose necklace sprite, not an installed scene preview. Historical showcase completeness is invalid. |
| Preview generated -> preOptions | English description and current Renew/unofficial title are present. Defect: description does not end with the required Steam-format Source code on GitHub link. Preview accent/secondary palette cannot be checked without the final image. |
| preOptions -> options | Independently passed as justified `settings_audit: not_applicable`; see below. |
| options -> l10n | Partial: existing injection paths pass, EN coverage is established, FR completeness for temporary sunlight objects remains unverified; see below. |
| l10n -> preTest | Source inspection finds only RimWorld/Verse/UnityEngine runtime dependencies and this mod's own classes. No Harmony, external aura library, optional integrations, conditional patches or LoadFolders file. About lists 1.6 and vanilla/DLC ordering hints, not mandatory DLC dependencies. No undeclared third-party dependency found; game loading remains unverified. Earlier gates prevent preTest. |
| preTest -> done | No functional scenario document or automated behavioral test suite exists in the project. XML/injection checks were actually executed successfully, but do not establish gameplay behavior. Required behavioral test coverage and execution remain pending, not a demonstrated gameplay failure. |
| done -> tested | Unverified: no current in-game scenario results, EN/FR UI checks, logs, new-game or existing-save regression evidence. RimWorld was not launched. |

### Settings audit

Reviewed all four C# files, the project file, Defs and patches. Eight pieces of apparel use
fixed design/balance values: effect cadence, quality multipliers, shoulder wear, affinity,
recovery rate, scarf aura and temporary sunlight. These are authored mechanics rather than
an existing player configuration contract; no concrete user setting requirement was found.
The README's XML tuning suggestion does not by itself justify exposing every balance value.
There is no Mod subclass/settings page, ModSettings persistence, settings UI or MainButtonDef.
Search for ModSettings, SettingsCategory, DoSettingsWindowContents and MainButton returned no
matches. Consequently there is no empty page or shortcut. Settings UI, input, persistence and
customization integration tests are not applicable; no RIMMSQOL compatibility was claimed tested.
The explicit audit prompt permits source verification for this no-settings case.

### Translation audit

**2026-09-30, French rule (three-segment gender switch, review by Virginie).** Every French file was read, none searched. French lives only in `Mod/Languages/French/DefInjected/` (`ThingDef/NeckAccessory.xml`, `ThoughtDef/Thoughts_NeckAccessory.xml`, `HediffDef/NeckAccessory.xml`, `ApparelLayerDef/ApparelLayerDefs.xml`); no Keyed file, no grammar file. No text agrees with a pawn through a switch. Two agreed in the masculine only and were reworded: the hero's scarf description (now "Voir cette écharpe au premier rang donne du cœur à quiconque la regarde.") and the hero's inspiration stage (now "Tant qu'il y a des héros, je ne me vois pas perdre !"). Flagged `?` in `FRENCH_REVIEW.md`: "héros" in three names; rose necklace "un homme" and lily "une femme" (fixed sex, not an agreement). `FRENCH_REVIEW.md` (mod root, outside `Mod/`) is generated by `_tools/Generate-FrenchReview.ps1`: regenerate after any text change. Review by Virginie: not done; `translation_fr` stays `partial`.

Earlier inventory (2026-09-29): eight apparel labels/descriptions, the apparel layer, three hediff definitions
and their stages, six thoughts and their stages, and the added vanilla Disfigured stage.
C# contributes identifiers and serialized data only, with no discovered player-facing string
construction. EN uses native English Def values plus grammar-polishing injections; the added
Disfigured label is valid English source and does not require a redundant English injection.
Read EN/FR resources directly; 45 EN, 46 FR and 43 Japanese entries are nonempty and have no
duplicate names within each language. Proper names and technical metadata are excluded.
No text placeholders or parameter mismatch was found in reviewed EN/FR content.

Executed `../scripts/Check-DefInjected.ps1 -TransMod <project>/Mod` with all streams captured:
31 patch operations applied, 11,611 definitions indexed, 134 keys checked, 0 errors.
This validates existing injection paths (including Disfigured), not exhaustive coverage.
The seven `HDA_SunLight_*` definitions have English label/description fields without French
injections (14 fields). They are nonselectable temporary buildings; their exposure through
mouse-over or other game UI has not been established. This is an unresolved coverage question,
not proof of visible English fallback. FR/localization remain partial until exposure is checked
and either translated or explicitly justified as internal. EN source coverage is complete.
In-game EN/FR display and regression checks remain unverified independently of static results.

### Executed checks and reproducibility

- All 19 distributed XML files parsed successfully with PowerShell's XML parser.
- Release build succeeded with 0 warnings and 0 errors. The first sandboxed attempt was blocked
  by SDK access; the authorized retry succeeded. Intermediates and outputs were redirected to
  `%TEMP%/NeckAccessoryRenew-audit-20260913/{obj,bin}` using BaseIntermediateOutputPath,
  MSBuildProjectExtensionsPath and OutputPath; shipped files were not replaced.
- Shipped and rebuilt `NeckAccessory.dll` have identical SHA256:
  `241E43C6456B96A6C502B02BE525B696D6E10072C261113303A6AAF122386793`.
- Source/XML manifest SHA256 (Source, Mod/Defs, Mod/Languages, Mod/Patches; sorted relative
  paths plus per-file SHA256, joined with LF):
  `A217A9541586F934098786A9C3548FEA323016AA3143EAD3AAE758DBDF571BF7`.
- LICENSE and ATTRIBUTION copies in Mod match their root copies byte for byte.
  MIT explicitly excludes original Udon content; it is not a third-party reuse grant.
  The existing `silent` classification is retained as recorded, not freshly certified:
  upstream Steam support, permissions/comments and any prohibition were not rechecked live.
- GitHub repository metadata and main commit were read using gh; no remote was changed.

### Required next work versus later work

For the next transition only: establish an autonomous checkout outside the monorepo, configure
its GitHub remote, verify the pushed revision corresponds to the intended content, and refresh
the upstream support/permission evidence supporting the recorded rights classification.
Retain the existing credits, licence scope and unpublished local changes.

Later gates require the icon style issue to be resolved, an installed compliant preview,
the final description link, closure of the sunlight translation coverage question, and applicable
behavioral scenarios/tests followed by actual in-game validation. These findings do not authorize
publishing, generating images or implementing features within this audit.

Optional recommendation: isolate build intermediates inside the future standalone project;
Directory.Build.props currently reaches the parent `.build` directory and retains the old name.
This does not invalidate the successful redirected audit build or the matching distributed DLL.
## Standalone transition — 2026-09-13

Current stage: `horsMonoRepo` (exact workflow label). This section supersedes the earlier
location, missing-preview and upstream-evidence findings while preserving that audit history.

- Authoritative checkout: `C:/Users/nelim/Documents/RimWorldMods/NeckAccessoryRenew`.
- Distributed folder: `Mod/` inside that checkout. Its own .git directory and top-level path
  were verified; it is physically outside the parent RimWorld monorepo.
- Cloned existing PUBLIC repository https://github.com/vbardales/Rimworld-Neck-Accessory,
  retaining origin and existing main history, initially at da7e9125ab75f8ec8c2b7f97335b9b05c10da486.
- Imported all current local files, retaining identifiers and prior local edits. The remote-only
  historical Preview.png was preserved, not newly generated or certified.
- Naming is intentionally non-identical: display name Neck Accessory Renew (unofficial),
  folder NeckAccessoryRenew, packageId nelim.neckaccessory, existing repository
  Rimworld-Neck-Accessory. Keeping technical identity and existing URLs preserves compatibility.
- README, CHANGELOG, scoped LICENSE and ATTRIBUTION are present in English; licence and
  attribution distributed copies match. Dated source and rights evidence is in ATTRIBUTION.md.
  Public/silent remains the project decision; unofficial notice, original credits and removal
  commitment are present. No third-party permission is inferred from the classification.
- Added .gitignore and .gitattributes. Build intermediates now stay in this repository's
  .build directory, outside Mod/. The build configuration comment is now English.
- `dotnet build Source/NeckAccessory/NeckAccessory.csproj -c Release --nologo` passed from
  the new checkout: 0 warnings, 0 errors. DLL SHA256 remains
  241E43C6456B96A6C502B02BE525B696D6E10072C261113303A6AAF122386793.
  All 19 XML files parsed; git diff --check passed. No runtime source or translation changed,
  so prior independent static checks remain applicable. No game or Workshop publication ran.
- The transition is committed and synchronized through origin/main; use the commit containing
  this section as its revision. Final local/remote equality is checked after pushing.

Next transition only: resolve the current ModIcon style discrepancy, preserving the verified
build result and checking the final installed image. Preview conformity, final description link,
sunlight FR coverage and gameplay tests remain separate later work. No later gate is certified.
## ModIcon transition — 2026-09-13

Current stage: `ModIcon générée` (exact workflow label), superseding the earlier icon finding.
Generated an original orange mascot with a wink, upper-right ponytail, burgundy collar and
sun pendant using OpenAI image generation. Installed Mod/About/ModIcon.png: 128x128 PNG,
18,693 bytes. Directly inspected both the installed image and the 32x32 thumbnail: face,
collar and sun pendant remain distinguishable; no text, frame or watermark. The broad outlines,
near-black background and limited orange/burgundy/gold palette follow the mascot convention.
Minor shading is visible in the source but does not impair the flat thumbnail presentation.

Preserved the previous icon as Art/ModIcon-before-mascot.png, generated source as
Art/ModIcon-mascot-source.png and inspection thumbnail as Art/ModIcon-32px-QA.png.
Only artwork/documentation changed. The previously verified build and matching DLL remain
applicable; no source, gameplay XML, settings or translations changed. No new gameplay
validation is claimed and RimWorld was not launched.

Next gate is Preview generated: inspect the historical installed Preview against the current
requirements, and correct only if needed. No preview conformity is inferred from this icon.
## Icon preference override — 2026-09-13

The user explicitly preferred the previous necklace-only icon over the generated mascot.
Restored Art/ModIcon-before-mascot.png byte for byte to Mod/About/ModIcon.png (128x128 PNG,
15,268 bytes), and directly inspected the restored design. This explicit user preference
supersedes the generic mascot convention. The absence of a mascot is therefore no longer
a defect for this mod, and stage remains `ModIcon générée`. The previous mascot acceptance
above is superseded; its source and QA image remain archived in Art/, not distributed.
No runtime, settings or translation changes. Existing build validation remains applicable.

## Preview transition and icon size check — 2026-09-13

Current stage: `Preview générée`, using the exact workflow label.
Rechecked the user's preferred installed ModIcon directly: PNG, 128x128, 15,268 bytes.
It is appropriately sized and was not changed.

Inspected the historical Preview: 896x504, 228,504 bytes, but its text retained the old name
and its background was an enlarged necklace sprite rather than the required colony scene.
Preserved it in Art/Preview-before-renew.png and generated a new tailoring-workshop preview
with OpenAI image generation. It shows neck armor, a scarf and a sun pendant on a worktable,
with the current Renew/unofficial title and English subtitle.

Installed Mod/About/Preview.png is PNG, 896x504, 725,197 bytes (below 1 MB).
Directly inspected the generated image, installed image and Art/Preview-268px-QA.png:
title and accessory silhouettes remain identifiable at thumbnail size; high oblique view,
plank floor and simple workshop composition have no concrete camera concern. Wood/charcoal
base, gold lamp/pendant accent and burgundy scarf are visually separated. Original generated
composition including typography is preserved as Art/Preview-renew-source.png.
No historical generation report or separate game screenshot comparison was used as a gate.

Runtime files, DLL, settings and translations are unchanged; their earlier independent
checks retain their scope. No in-game validation is claimed. The next transition is preOptions:
finish the required final Steam-format source link and check description/name conventions.
