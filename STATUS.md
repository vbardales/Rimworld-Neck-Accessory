---
localization: partial
translation_en: complete
translation_fr: partial
mod:          Neck Accessory Renew (unofficial)
packageId:    nelim.neckaccessory
repo:         Rimworld-Neck-Accessory
visibility:   public
detached:     yes
stage:        ModIcon générée
settings_audit: not_applicable
licence:      silent
licence_at:   ATTRIBUTION.md, upstream review 2026-09-13
dependencies: none
showcase:     partial
tested_on:
workshop:
remaining:
  - unverified: historical Preview.png restored from GitHub, conformity not audited
  - defect: required final Steam-format source link is missing
  - unverified: sunlight object UI exposure and French coverage
  - unverified: behavioral scenarios and automated tests
  - unverified: in-game EN/FR UI, logs, new game and existing save
session:      maj:        2026-09-12, releve automatique
updated:      2026-09-13, evidence-based audit
---

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

Inventory: eight apparel labels/descriptions, the apparel layer, three hediff definitions
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