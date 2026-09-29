# Artwork

- `Preview-before-icon.png`: the installed Preview before the icon was added (title over the scene). It is the base of
  `_tools/compose-preview.cjs`, which always starts from it, so re-running never stacks icons.
- `Mod/About/Preview.png` = that base plus `Mod/About/ModIcon.png` cut out of its background (flood fill from the border,
  never a global threshold) in the bottom-left corner, 150 px, tilted +15deg, bleeding 22 px off the left and bottom edges.
  Rule of 2026-09-29: left corner +15deg, right corner -15deg. Run `node _tools/compose-preview.cjs` (sharp on the Node path).
- `Workshop/`: the images to upload, and nothing else. `00-preview.png` is a byte-for-byte copy of `Mod/About/Preview.png`;
  recopy it whenever the Preview changes. Captures follow as `01-`, `02-`... (none yet).
- `ModIcon-before-mascot.png`, `ModIcon-mascot-source.png`, `ModIcon-32px-QA.png`, `Preview-before-renew.png`,
  `Preview-renew-source.png`, `Preview-268px-QA.png`, `Preview-source.png`: earlier states and sources, kept as visual trace.
- `ModIcon.ico`, `Preview.ico`: local Windows folder icons, ignored by git, never in `Mod/`.
