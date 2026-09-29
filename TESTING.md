# Testing Neck Accessory Renew

Two layers, and the order matters: everything provable without the game is proved without it, because a
Pickle run takes over a machine for tens of minutes and an offline check takes a few seconds.

| Layer | What runs it | What it covers |
| --- | --- | --- |
| Offline suite | `_tools/Test-Mod.ps1` (Windows PowerShell 5.1) | XML well-formedness; every extension, worker and thing class named by a def exists in the sources and in the compiled assembly; every field a def sets exists on its class; every hediff named exists; one sun light per quality; quality tables of 7 entries; every piece on the mod's own apparel layer; the vanilla-Disfigured patch applied to synthetic defs (vanilla shape, a shape with a stage from another mod, an untouched neighbour, a negative control); French label and description for every owned def; About, images and the licence copies; the Pickle steps used by the features exist |
| In-game suite | `Tests/Pickle/` | what needs a map, a pawn and a clock: the mechanism, the thoughts, the defs as the loaded game holds them |

```powershell
dotnet build Source/NeckAccessory/NeckAccessory.csproj -c Release
dotnet build Tests/Pickle/Source/NeckAccessory.PickleSteps.csproj -c Release
powershell.exe -ExecutionPolicy Bypass -File _tools/Test-Mod.ps1
```

## Why the mechanism needs a running game

In 1.6 worn apparel is never ticked, so every effect is driven by `NeckAccessoryMapComponent` walking the
pawn list. A broken component leaves all eight pieces inert and logs nothing. Nothing offline can show a
severity moving, a trait settling or a light following a pawn: each Pickle scenario changes something and
has a control that must not change.

## What covers what

| Behaviour | Covered by | Control in the same scenario |
| --- | --- | --- |
| Heavy neck armour stiffens the shoulders | `02` scenario 1 | a colonist who wears nothing stays at 0 |
| Swindler's necklace eases stiff shoulders | `02` scenario 2 | Awful work (factor 0) leaves 0.5 unchanged |
| Rose necklace: affinity and trait, worn by a man | `02` scenario 3 | the trait is stripped first, so a pre-existing one cannot pass it |
| Rose necklace worn by a woman unwinds it | `02` scenario 4 | the trait is given first |
| Lily necklace, mirror of the rose | `02` scenario 5 | |
| Sun necklace lights the wearer's cell and leaves nothing behind | `02` scenario 6 | after it comes off, no light remains |
| Hero's scarf heartens allies in 15 tiles | `02` scenario 7 | one ally 42 cells away and the wearer itself get nothing |
| Masochist's choker, sun necklace, rose and lily necklaces, two scarves | `03` | the opposite trait or sex reads the other stage |
| Vanilla Disfigured carries the patch's worker and stage | `01` | offline suite proves the patch on synthetic defs |
| Every piece is a def of the loaded game | `01` outline | |
| Every quality has a sun light | offline | |

**Not covered, and why.** The hero's scarf changing how scars read (`ThoughtWorker_Disfigured_ProofOfHero`,
stage 1 for the faction's own people) has no scenario: it needs a colonist with a visible scar and the
vanilla worker's own acquaintance rules, neither of which the built-in steps can set up, and a step written
blind would test the fixture more than the mod. The worker and the patch are covered (`01`, offline); the
stage choice is `unverified`. Settings: none exist, see `STATUS.md`. The game's reaction to a language
switch is the game's, not the mod's.

## Passes

`../AUDIT.md` asks for three families. This mod needs **two runs and neither of the other families applies**:

| Pass | Command | What it proves |
| --- | --- | --- |
| minimal, English | `scripts/Run-PickleWsl.ps1 -Mod NeckAccessoryRenew` (through `Submit-PickleRun.ps1`) | the whole suite against Core, the DLC, Harmony, RimLogging, Pickle and this mod; the only set the mod loads in |
| minimal, French | the same with `-Language French` | the same features under a French game: no step spells a label, so the features are unchanged |

**No pass with optional mods.** `About.xml` has no `modDependencies` and its `loadAfter` names Core and the
DLC only: there is no optional mod to add. **The day `loadAfter` names another mod, this table is wrong.**
**No incompatibility pass:** nothing in the README, CHANGELOG or description claims a conflict. **No
DLC-absent pass:** the mod guards nothing behind a DLC; its `loadAfter` on the five DLC is ordering only.

## Manual tests

None. Nothing is left to tick by hand: what a person must look at is not a test. The pieces have no worn
texture (inherited from 1.0, stated in the description), so there is no capture to review.

## What has actually been run

- Offline suite: 24 checks, all green on 2026-09-29.
- The steps assembly compiles (0 warnings, 0 errors).
- **The Pickle suite has never been played.** Its features and steps were written without a run. The first
  run may fail on a step, a def name or a coordinate before it says anything about the mod: read the report,
  do not read a red as a defect of the mod until the fixture is ruled out.

## What to keep after a test, and what to delete

Evidence stays on disk, never in git (`Tests/Pickle/Evidence/`, `Tests/Pickle/results/` and `evidence/` are
ignored, as is `*.dds`). Keep, per scenario, the newest report for the revision now in the repository, plus an
older one only if it is the sole proof of a check the newest did not repeat. Keep `summary.json` or
`summary.md`, `junit.xml`, `messages.ndjson` and `Player.log`; minify any screenshot kept, and never copy the
shared `screenshots/` folder whole. One text line per run in `docs/runs/history.md`. Check `exitReason`
before the counts and `flaky` in `summary.json`. Never delete a report a `STATUS.md` field points to.
