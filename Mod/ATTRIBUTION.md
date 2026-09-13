# Attribution

## NeckAccessory [1.0]

- **Original author:** Udon
- **Source:** Steam Workshop `1611488293`, last supported version 1.0, last updated
  26 January 2019 — https://steamcommunity.com/sharedfiles/filedetails/?id=1611488293
  The page was fetched on 2026-09-13; see the dated rights review below.
- **Reused here:** the whole mod — defs, textures, Japanese translation, and the logic of the six
  assemblies, rewritten.

## Licence

**No licence is declared**: there is no `LICENSE` file in the mod, and its Steam description says
nothing about reuse. The mod is republished under the usual practice for abandoned mods — explicit
credit, a link to the original, and removal on request. That is stated in the mod's own
description, not only here.

If Udon asks for this to be taken down, it comes down. Immediately, and without discussion.

### The six assemblies

The mod shipped `Choker.dll`, `HeavyNeckArmor.dll`, `LoveNecklace.dll`, `ProofOfHero.dll`,
`SunNecklace.dll` and `SwindlerNecklace.dll`, plus a copy of Harmony that served no purpose: not one
of the six applied a patch. Around 700 decompiled lines in all, merged into a single
`Mod/Assemblies/NeckAccessory.dll` (source in `Source/`).

**What condemned the mod as it stood:** four of the eight pieces were `Apparel` subclasses driving
themselves from their own `Tick()`. **In 1.6, worn apparel is never ticked** — `Pawn_ApparelTracker`
only handles wear and locking now. The heavy armor, the two flower necklaces, the swindler's and the
sun's would therefore have done nothing at all, without a single load-time error to say so.
Everything is now driven by a `MapComponent`, which walks the pawn list only on the ticks where an
effect is actually due.

| Point | Decision |
|---|---|
| `ThingDef_GetHediff` ×3, `ThingDef_HediffAura` | `ThingDef` subclasses replaced by `DefModExtension`s. A def no longer has to belong to a mod to carry its settings. |
| `HealthDifferenceAuraCore` (`1544596991`) | Dead and nowhere to be found. The scarf's aura is rewritten here, in the mod's own namespace so it stays independent of the [[WA]] port, which has its own. |
| Vanilla `Disfigured` def | The mod **redefined it outright** to graft the scarf's bonus onto it, overwriting whatever the game or another mod puts there. Replaced by a patch that touches only the `workerClass` and adds the positive stage. |
| `HediffDefOf.BadBack`, `.Frail`, `.Cataract` | Gone from the `HediffDefOf` class since 1.0, while the defs themselves still exist. The list of ills the swindler's necklace mends moved to XML. |
| `TailoringSpeed`, `SmithingSpeed`, `UnskilledLaborSpeed` | Folded into `GeneralLaborSpeed`. |
| `traits.allTraits.Remove(...)` inside a loop over `allTraits` | Modifying a list while walking it. Replaced by `GetTrait` + `RemoveTrait`. |
| Pieces recognised by `apparel.ToString().IndexOf("HDA_...")` | Straight `defName` comparison. Same test, without building a string per garment per social tick. |
| `tickerType Normal` on the apparel | Dropped: it has no effect once the piece is worn. |

Checked against RimWorld 1.6.4871.

### Left untouched, and worth knowing

**The swindler's necklace barely heals** a bad back, frailty and cataracts. The original figures
give 0.00001 severity per dose, one dose every 6000 ticks: about 0.0001 per in-game day, where a bad
back sits at 0.6. It would take thousands of days. Only stiff shoulders really move, receiving a
thousand times as much. That is the author's balancing, not a break in the port — left as it stands,
and one word away in `Mod/Defs/ThingDefs_Misc/NeckAccessory.xml` (`severityPerDose`) if you want it
to show.

**No piece is visible on the pawn.** The mod provides no `wornGraphicPath` and none of the textures
that would go with it — the `_m` files it ships are masks for the `CutoutComplex` shader, not worn
views. That was already the case in 1.0.

## Upstream rights review — 2026-09-13

Reviewed the original Steam description and all five comments displayed for item 1611488293,
and the installed original About.xml and file inventory. Steam lists version 1.0 and an update
on 26 January 2019; installed metadata supports 1.0 only. No declared 1.6 support, licence,
explicit reuse permission or explicit prohibition was found in those sources. The original
file inventory contains no licence/readme/copyright file. This is a scoped search result,
not proof that no other statement exists.

Under the project workflow the source remains `silent` (no declared 1.6 support and no reuse
permission found). The existing repository remains public, with the unofficial title,
explicit lack-of-consent notice, original credits and removal commitment. This classification
and publication convention grant no rights over Udon's work. The scoped MIT notice covers
only original contributions by nelim; it does not relicense inherited or derived third-party
content. Steam visibility was not used to infer author intent or withdrawal.

Source: https://steamcommunity.com/sharedfiles/filedetails/?id=1611488293&l=english
Local reference: Steam workshop/content/294100/1611488293/About/About.xml.
## New ModIcon — 2026-09-13

The mascot ModIcon was generated with OpenAI image generation for this continuation.
It is separate from Udon's original textures and artwork; the original assets retain their
existing rights status. The previous icon and generated source are preserved in Art/.


The user subsequently selected the previous necklace-only icon, restored as the distributed
ModIcon. The OpenAI-generated mascot is archived in Art/ and is not the installed icon.


## New Preview — 2026-09-13

The current workshop-scene Preview and its typography were generated using OpenAI image
generation for Neck Accessory Renew. The historical preview and new generated source are
preserved in Art/. This new illustration does not change the rights status of original assets.
