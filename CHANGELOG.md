# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it
in game.

## [1.0.0] — unreleased

On release: create the `v1.0.0` tag and the matching GitHub release.

First release of the 1.6 update of Udon's **NeckAccessory [1.0]**, last updated 26 January 2019.
Unlike a straight rebuild, this one had to move the whole mechanism: on 1.6 most of it would have
run nowhere.

### Changed

- **Every effect is driven from a `MapComponent`.** Four of the eight pieces were `Apparel`
  subclasses working from their own `Tick()`, and 1.6 never ticks worn apparel —
  `Pawn_ApparelTracker` only handles wear and locking. The heavy armor, the rose and lily
  necklaces, the swindler's and the sun's would have done nothing at all, with no error at load to
  say so. The component walks the pawn list only on the ticks where an effect is due.
- **The six assemblies are merged into one.** `Choker`, `HeavyNeckArmor`, `LoveNecklace`,
  `ProofOfHero`, `SunNecklace` and `SwindlerNecklace`, roughly 700 decompiled lines, rewritten as a
  single `NeckAccessory.dll`.
- **The vanilla `Disfigured` thought is patched, not redefined.** The original replaced the def
  outright to attach the scarf's bonus, discarding whatever the game or another mod puts there. The
  patch now touches the `workerClass` only, and adds one stage.
- **`ThingDef` subclasses replaced by `DefModExtension`s**, so settings no longer require the def to
  belong to this mod.
- **The scarf's aura is reimplemented in this mod.** It relied on `HealthDifferenceAuraCore`
  (`1544596991`), which is dead and cannot be found.
- **The swindler's necklace reads its list of ills from XML.** `BadBack`, `Frail` and `Cataract`
  left `HediffDefOf` after 1.0, though the defs themselves still exist.
- **`TailoringSpeed`, `SmithingSpeed` and `UnskilledLaborSpeed`** replaced by `GeneralLaborSpeed`,
  which absorbed them.
- **Pieces are recognised by `defName`** instead of searching `apparel.ToString()` for `"HDA_"`,
  which built a string per garment per social tick.
- **Hediff and thought stage keys use translation handles** rather than list indices, matching the
  scheme the game's own translations use.

### Added

- Support for RimWorld 1.6. Checked against 1.6.4871.
- An English translation, fixing the original's machine-translated wording without changing what it
  says or how much it discloses.
- A French translation, covering the items, thoughts, hediffs and the apparel layer.
- `LICENSE`, MIT over the update work alone. Udon's textures, artwork, defs and Japanese
  translation are outside it.

### Fixed

- **A list modified while being walked.** `traits.allTraits.Remove(...)` ran inside a loop over
  `allTraits`; it is now `GetTrait` + `RemoveTrait`.

### Removed

- The copy of Harmony shipped alongside the six assemblies. None of them applied a patch.
- `tickerType Normal` on the apparel, which has no effect once a piece is worn.

### Notes

Two defects inherited from the original are left in place on purpose and documented in
`ATTRIBUTION.md`: no piece is drawn on the pawn, and the swindler's necklace heals so slowly that
only stiff shoulders move at a noticeable rate.

## 2026-09-13 — Standalone repository

- Adopt the Neck Accessory Renew (unofficial) title while preserving package and save identifiers.
- Establish the standalone checkout, keep build intermediates local, and refresh the scoped upstream rights review.
- Preserve existing artwork and runtime behavior; no in-game validation is claimed.

## 2026-09-13 — Mascot icon

- Replace the necklace-only icon with the orange mascot and sun pendant; verify at 128 and 32 pixels.
- Preserve the previous icon and generated source in Art/.

## 2026-09-13 — Restore preferred icon

- Restore the previous necklace-only ModIcon at the user's request, overriding the generic mascot convention.
