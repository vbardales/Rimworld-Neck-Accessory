# Neck Accessory 1.6

Update of Udon's **NeckAccessory [1.0]** to RimWorld 1.6.

**I am not the author of this mod.** The design, the textures and the original idea are entirely
Udon's — all I did was the work needed to make it run on 1.6. Credit goes to them; mistakes in the
update are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=1611488293 (stays on 1.0, last
updated 26 January 2019). The page is still online; the mod is abandoned, not withdrawn.

## What the mod does

It adds eight pieces worn at the neck, on an apparel layer of their own, so none of them competes
with a shirt, a duster or a helmet.

- **Neck plate** — forged armor, protecting the neck alone.
- **Heavy neck armor** — highly protective, but wearing it for long ends in stiff shoulders. The
  shoddier the piece, the sooner: quality scales the wear three-fold at awful, halves it at
  legendary.
- **Hero's scarf** — heartens allies within fifteen tiles with a combat buff that decays fast once
  they leave. It also changes how others read the wearer's scars: not a disfigurement but a record
  of service. Two wearers in the same faction cannot stand each other — there is room for only one
  hero.
- **Masochist's choker** — humiliating for almost everyone, a delight for whoever has the matching
  trait.
- **Rose necklace** and **lily necklace** — worn by the sex they address, they build an affinity
  that eventually settles as a trait; worn by the other, they unwind it and take the trait back
  with them. They also shift how others feel about the wearer.
- **Swindler's necklace** — mends a bad back, frailty, cataracts and stiff shoulders.
- **Sun necklace** — lights the ground around whoever wears it, wherever they go. A little
  dazzling, and thoroughly unpleasant for an undergrounder.

No DLC required. No Harmony required — the mod applies no patches through it.

Available in English, French, and Udon's own Japanese.

Content mod: removing it mid-save destroys any pieces already crafted.

## What changed in the 1.6 update

**The mod would have been half-dead on 1.6, silently.** Four of the eight pieces were `Apparel`
subclasses driving themselves from their own `Tick()`. In 1.6 worn apparel is never ticked —
`Pawn_ApparelTracker` only handles wear and locking. The heavy armor, the two flower necklaces, the
swindler's and the sun's would have done nothing at all, without a single load-time error to say
so. Everything is now driven from a `MapComponent` that walks the pawn list only on the ticks where
an effect is actually due.

The six shipped assemblies — `Choker`, `HeavyNeckArmor`, `LoveNecklace`, `ProofOfHero`,
`SunNecklace`, `SwindlerNecklace` — are merged into one, about 700 decompiled lines rewritten. The
copy of Harmony that travelled with them is gone: not one of the six applied a patch.

Other things the 1.6 game files forced or allowed:

- **`HealthDifferenceAuraCore` is dead** and nowhere to be found. The scarf depended on it; its
  aura is rewritten here, in this mod's own namespace.
- **The vanilla `Disfigured` thought is no longer overwritten.** The original redefined the def
  outright to graft the scarf's bonus onto it, throwing away whatever the game or another mod puts
  there. It is now a patch touching only the `workerClass`, plus one added stage.
- **`ThingDef` subclasses replaced by `DefModExtension`s**, so a def no longer has to belong to a
  mod to carry its settings.
- **`BadBack`, `Frail` and `Cataract` left `HediffDefOf`** after 1.0 while the defs themselves
  stayed. The list of ills the swindler's necklace mends moved to XML.
- **`TailoringSpeed`, `SmithingSpeed` and `UnskilledLaborSpeed`** are folded into
  `GeneralLaborSpeed`.
- **A list was being modified while it was walked** — `traits.allTraits.Remove(...)` inside a loop
  over `allTraits`. Replaced by `GetTrait` + `RemoveTrait`.
- **Pieces were recognised by `apparel.ToString().IndexOf("HDA_...")`**, once per garment per
  social tick. Straight `defName` comparison now: same test, no string built.
- **English and French translations added.** The Japanese that ships with the mod is Udon's. Stage
  keys use the handle scheme Core itself uses rather than list indices.

Checked against RimWorld 1.6.4871.

## Known limitations, inherited and left alone

- **Nothing is drawn on the pawn.** The mod provides no `wornGraphicPath` and none of the textures
  that would go with it — the `_m` files it ships are masks for the `CutoutComplex` shader, not
  worn views. That was already true in 1.0, and inventing artwork would make this a rewrite rather
  than an update.
- **The swindler's necklace barely heals anything but shoulders.** The original figures give
  0.00001 severity per dose, one dose every 6000 ticks — about 0.0001 per in-game day, where a bad
  back sits at 0.6. Stiff shoulders receive a thousand times as much and do move. It is the
  author's balancing, one word away in `Mod/Defs/ThingDefs_Misc/NeckAccessory.xml`
  (`severityPerDose`) for anyone who wants it felt.

Both are documented in [ATTRIBUTION.md](ATTRIBUTION.md), file by file, alongside everything that
was taken and everything that was changed.

## Terms

The original mod declares no licence. This update is published under the usual practice for
abandoned mods: **explicit credit to Udon, a link to the original, and removal on request.** If
Udon comes back to the mod, or asks for this to be taken down, it comes down.

`LICENSE` is MIT over the update work alone — the C#, the English and French translations, the
patch and the build files. Udon's textures, artwork, defs and Japanese translation are not covered
by it and cannot be.

If I do not answer within a reasonable time after being contacted, anyone may freely update this or
any other of my mods, including publishing a continuation of it. All credit must be preserved.

## Building

```
dotnet build Source/NeckAccessory/NeckAccessory.csproj -c Release
```

Reference assemblies come from NuGet (`Krafs.Rimworld.Ref`), so no RimWorld install is needed to
compile. The output goes to `Mod/Assemblies/`; build intermediates are kept out of the mod folder
by `Source/Directory.Build.props`, because the Workshop uploader publishes the mod folder as-is
with no way to exclude anything. That is also why `Source/` sits beside `Mod/` rather than inside
it.

## Credits

- **Udon** — the mod itself, in full: design, textures, defs, Japanese.
- 1.6 update by nelim. Written with the help of Claude (Anthropic).
