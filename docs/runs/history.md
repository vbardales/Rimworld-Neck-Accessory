# Runs history

One line per run. Newest last.

- 2026-09-29 audit (no game run): standalone checkout aligned to origin/main e0c80b7, Source link added to the About description, stage retained `showcase` / `options`. No Pickle run, no evidence on disk.
- 2026-09-29 tests written (no game run): offline suite 24/24 green; Pickle suite 3 features written, steps assembly builds, never played. Stage done.
- 2026-09-29 Preview now carries the cut-out ModIcon (bottom-left, +15deg); Art/Workshop/00-preview.png added; offline suite 25/25.
- 2026-09-30 l10n: French gender rule applied (two texts reworded), FRENCH_REVIEW.md generated, translation_fr partial, review by Virginie pending.
- 2026-10-14 playTests: initial Pickle pass, minimal English (ticket 20261014-100025-201-4468, set sans-facultatifs, tree after 538da7a): 23 of 23 passed (16 scenarios, 8-piece outline), exitReason passed, evidence Tests/Pickle/Evidence/initial-English-bfab278. The only ERROR in Player.log is the game noting that the Pickle companion mod loads no content, expected.
- 2026-10-15 playTests: optional passes, English, filtered to rose, lily and thoughts, tree 130bb36: sexualite 10/10, rimpsyche 10/10, split-attraction 6/10 (the 4 rose and lily scenarios fail: Split Attraction replaces the Gay trait with SplitAttraction_Gay). Initial French ticket 20261014-100025-724-8e59 produced no report (game restarted under the lock after the language switch), retried.
