# Artwork

The reproducible Preview sources are `Art/Preview-source.png`, `Art/echo-source.png`,
`Art/ModIcon-source.png`, and `Art/Preview.config.json`. From the repository root, run:

```text
node ../scripts/Render-Preview.cjs
```

The shared renderer writes `Mod/About/Preview.png`, `Art/Gallery/0-preview.png`,
`Art/Preview.ico`, and `Art/ModIcon.ico`. Temporary checks live under `Art/.render/` and
are not publication assets. `Art/Gallery/` contains only uploadable images.

`Art/ModIcon-before-mascot.png` keeps the necklace-only icon that `Mod/About/ModIcon.png`
still ships, until the icon is regenerated from `Art/ModIcon-source.png`.
