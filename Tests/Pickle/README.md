# Pickle suite: Neck Accessory Renew

Development only, never published. The companion mod `Mod/` (packageId `nelim.neckaccessory.pickletests`)
holds the features; `Source/` builds the steps assembly into `Mod/Pickle/Assemblies/`.

Scope, pass matrix and what is deliberately not covered: `../../TESTING.md`.

| File | Scenarios | What |
| --- | --- | --- |
| `01-the-loaded-defs.feature` | 1 + 8 (outline) | the Disfigured thought as the loaded game holds it; every piece is a def |
| `02-the-effects.feature` | 7 | armour, swindler's, rose (man, woman), lily, sun, scarf; each with a control |
| `03-the-thoughts.feature` | 6 | choker (two traits), sun necklace (two stages), rose, lily, two scarves |

Steps: `Source/NeckAccessorySteps.cs`, every text starts with `Neck Accessory:`. It references no assembly of the
mod: defs are found by defName.

No `wsl-deps.*.map` and no `wsl-ids.map`: the pass stages nothing beyond the mod itself, which has no
dependency. Pickle's `test-colony` fixture is the starting map; the scenarios spawn and dress their own colonists.

Run through the dispatcher, never directly:

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\Users\nelim\Documents\rimworld\Rimworld-Ticket-Dispatcher\scripts\Submit-PickleRun.ps1 -Mod NeckAccessoryRenew -Owner local_<id> -Label "<sha> minimal English" -EvidenceDir NeckAccessoryRenew/Tests/Pickle/Evidence/<run>
```

Add `-Language French` for the second pass. The mod is staged from the working tree when its ticket is played:
leave the tree on the revision to test until `RUN_DONE`.
