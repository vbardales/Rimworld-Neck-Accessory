---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Neck Accessory Renew (unofficial)
packageId:    nelim.neckaccessory
repo:         Rimworld-Neck-Accessory
remote:       https://github.com/vbardales/Rimworld-Neck-Accessory.git
visibility:   public
detached:     yes
workflow_stage: shootGallery[1.0.0]
settings_audit: not_applicable
licence:      silent
licence_at:   ATTRIBUTION.md, upstream review 2026-09-13
upstream_mod_remotes:
  - N/A
dependencies: none
showcase:     partial
tested_on:    2026-11-02
code_review_sha: d6e85bc31125a087bbe4592674e9f8729aacca6d
workshop:     3811292051   # private item, prepublished 0.1.0 on 2026-10-01
remaining:
  - "2026-11-12: probe d414 done (6/6), cells read from Player.log, probe feature and Inbox folder deleted. Cells fixed in 04-gallery-captures.feature (Shogun 222,238; Nelim walk target 153,100; Yuki 139,69; bonsai 139,122; others already free). 2026-11-12 candidates: image 1 (fd3e, Inbox/gallery-123b), image 2 (d400, Inbox/gallery-3), image 3 (d954, Inbox/gallery-3b: Character tab with Gay trait, HUD hidden, Harmony added to the map). Next: scenes 4 to 6 (zoom, as 1 to 3), then 9.c order, subtitles. Earlier: image 3 refiled as 0f79 (developer mode off keeps the pane, ee7e4ac); image 2 restaged east of the green cube (SaB: unidentified, stage around it) and refiled. Ticket fd3e (images 1 to 3 at a672e5d, tighter zoom): green 3/3; looked at 2026-11-12: image 1 good (necklace readable), image 2 ok but a green cube object at about (152,100) overlaps Nelim, image 3 still no Character tab (only the selection card) - asked PiT 2026-11-12. Earlier: ticket 1c59 (images 1 to 3, b45b959): green 3/3, cells ok (02d2 matched nothing: filter needs 04-gallery-captures::); captures looked at 2026-11-12: image 3 not zoomed on the pieces, Character tab absent, pawns off the planned spots, images 1 and 2 wide with the piece about 10 px (j weak) -> rework before images 4 to 6; then rework scenes 1 to 5 to 5/5, then images 4 to 6. Test shape conversion done 2026-11-12 (Rule-OwnValues.ps1 added, Test-Mod.ps1 and PatchEngine.ps1 deleted, LOCAL_SCRIPTS row replaced): CI/CD generated .github and Test-Mod.ps1 (stamp b55ad31e7d6c, 6/6 pass, junction mounted, committed); Audit validated the LOCAL_SCRIPTS row (2026-11-12), conversion complete"
  - "2026-11-10: ticket 91d2 (images 1 to 3 at 0c365f5) failed 0/3, each on a non standable cell (221,238 Shogun; 152,100 Nelim walk target; 139,68 Yuki). Asked PiT for standable cells (workshop, flower-garden, hut, then clearing, infirmary, bridge); on answer fix cells in 04-gallery-captures.feature, rework scenes 1 to 5 to 5/5 (plan score 2026-11-10: tighter zoom on the piece, visible object for g on 3 and 5), then refile images 1 to 3 and only then 4 to 6 and the two windows; then 9.c order, 9.e table, subtitles (Art/Gallery-clean + Add-Subtitle), 9.f move to mountPreview"
  - "2026-11-10: Check-FeatureDefs.js false negative on HDA_* defs (NeckPlate, HeavyNeckArmor, Masochists_Choker, LilyNecklace, RoseNecklace) at submit: ticket filed with -SkipDefCheck (image 3 had already worn HDA_RoseNecklace); tell PiT if it persists"
  - "2026-11-02: STATUS.md is over 40 KB (linter WARN): move the journal sections to docs/runs/ at a quiet moment"
  - "2026-10-27: defect (code review, left): GainTrait of the Gay trait has no conflict check with other sexuality traits (Bisexual, Asexual, Split Attraction orientations), and the old orientation is not restored when the necklace takes the trait back"
  - "2026-10-27: defect (code review, left): the necklace stores only the pawn id, not which Gay trait it gave: with both vanilla Gay and SplitAttraction_Gay on a pawn, FindGay may remove the wrong one"
  - "2026-10-27: defect (code review, left): a recorded pawn id is not dropped when another mod removes the trait; pawns given the trait by a build before 538da7a are not recorded and keep it; ids of dead pawns are never purged (no effect on behaviour)"
  - "2026-10-27: unverified (code review): no scenario saves and reloads, so ExposeData of NeckAccessoryGameComponent is not tested"
  - "2026-10-14: feature: every optional mod actually played (Sexuality Traits (Continued), Edges of Acceptance, [SYR] Individuality (Continued), Sexuality Genes, Split Attraction, Rimpsyche - Sexuality and its core) must be thanked in the Steam description and covered by a WORKSHOP_COMMENTS.md entry at writeDocs"
  - "2026-10-14: unverified (code review): GainTrait(Gay) has no conflict check with other sexuality traits; Shine spawns the sun light with WipeMode.Vanish on the wearer's cell, which may wipe furniture there (check in game)"
  - "2026-10-14: defect (code review, left): ThoughtWorker_Disfigured_ProofOfHero uses ActiveAtStage(1), wrong if another mod adds a Disfigured stage"
  - unverified: English defects left as shipped, not corrected (a day light, humilious, This collar is so excited!): a public port with no upstream repository and no explicit licence, no local fix or pull request
  - unverified: whether the sunlight objects are exposed in any game UI (mouse-over, inspect)
  - unverified: the Pickle suite (Tests/Pickle, 16 scenarios + 8-piece outline) has never been played; two passes, English and French, are the criteria of done -> tested
  - unverified: which stage the hero scarf gives the Disfigured thought (no scenario, see TESTING.md)
  - unverified: in-game EN/FR UI, logs, new game and existing save
  - unverified: current upstream permission and supported-version evidence (Steam page 1611488293 not rechecked)
  - unverified: Check-Translations WARN, ThoughtDef/Disfigured.stages.proof_of_hero.label has a French injection outside the text inventory (a stage added by a patch); the earlier audit found the path valid
  - unverified: social preview not uploaded to GitHub after the Preview was re-rendered on 2026-10-13 (social_preview_sha256 absent; web step, belongs to mountPreview)
session:      maj:        2026-09-12, releve automatique
updated:      2026-11-12, cells of the six places fixed from the probe, shootGallery
protocols_read_sha: b1cd02265b4a188864e5a94ea33e57ee4b09b448
---

## Pickle passes - 2026-10-15

- Initial English (`20261014-100025-201-4468`, set sans-facultatifs): 23/23 passed.
- `sexualite` (`20261014-165256-901-d07c`, 130bb36, filtered, English): 10/10 passed. `rimpsyche` (`20261014-165259-216-d300`): 10/10 passed.
- `split-attraction` (`20261014-165257-989-4055`): 6 passed, **4 failed**: the rose (man, woman, innate-trait control) and lily scenarios, `Wearer has no trait Gay; traits: ..., SplitAttraction_Gay, SplitAttraction_Heteroromantic`. Not a flaky run: the mod replaces the Gay trait with its own. See `remaining`.
- Initial French (`20261014-100025-724-8e59`): no report, retried.

### Code review - 2026-10-27 (8.m, range cfae258..61097be)

Independent Opus read-only review: 1 high, 1 medium, 5 low, no blocking finding on Split Attraction absent, a pawn who already had the trait, or silent-passing steps. The high finding (the granted-pawn list lived in a MapComponent, lost with its map or missed on another map) is fixed at `5f5c3d9`: the list is now on `NeckAccessoryGameComponent`, built clean (0 warnings), DLL committed with it, offline suite 25/25. Owner chose to fix the high finding only (Virginie, in the chat); the others are in `remaining`. The new list is saved under the same key `grantedGay`, now at game level: a save made between 538da7a and 5f5c3d9 loses the records (no release carried it). `code_review_sha` waits for the replay.

### Replay green - 2026-11-02

Ticket `20261027-012303-669-87b8` (set `sans-facultatifs`, tree `5f5c3d9`, played 2026-11-02): 4/4 passed, `exitReason` passed, the rose (man, woman, innate-trait control) and lily scenarios green on the GameComponent. Evidence minified in `Tests/Pickle/Evidence/rose-lily-5f5c3d9` (with `RELEASE.md`). `code_review_sha` written (HEAD `d6e85bc`: only STATUS, docs and Preview changed since `5f5c3d9`). Moved to `shootGallery[1.0.0]` the same day (session code NeA given by Virginie). `tested_1_7` stays absent: the 1.7 pass has its tool prerequisites (AUDIT.md, "Passe 1.7").

### Shotlist - 2026-11-02 (9.0, self-score 4.5, no capture yet)

Constraint: nothing is drawn on a worn piece (README), so every scene shows the mod by a carried or floor item, the sun-light pool, or an inspect tab. Story: one working day of Nelim, the only colonist of the Sanctuary, testing the neck pieces she has made; Soren (her male alter ego) is the only guest and wears the pieces for men; hours 06, 08, 10, 12, 15, 22, one hour per image (each scenario sets its own hour). Outfits kept all day: Nelim teal shirt `Apparel_BasicShirt` dyed (30, 100, 110) over the fixture trousers and corset, canon high ponytail with side locks, `MouthSmile` then her own face step last; Soren the canon look of `APPARENCES-CANON.md` (blue-grey `Apparel_CollarShirt` (110, 130, 150), brown trousers, `Roo_HD_Hair_Tidy`, sky-blue eyes; the olive shirt of the first draft is dropped), constant face. Pawns are placed after the waits. Opus director's pass kept: scene 2 a gift instead of a pair, scene 3 no tea pouring (no step), scene 4 the heavy armour instead of a tab, scene 5 no bed (no step for a colonist lying in one), zoom 7 on scenes 1 and 6, two tabs only (3 and 5), W2 = the choker's card. Not kept: dogs looking at Nelim; the front view is got by walking toward the camera (4, 6).

| # | name, place, hour, weather, time | subject, instant, gesture and how | composition, decor, living | steps and mods | subtitle |
| --- | --- | --- | --- | --- | --- |
| 1 | `1-dawn-workshop`, preindustrial-workshop, 06 Clear, +60 ticks | Sun Necklace, held up toward the window; instant: just polished, about to try it; `carries the item "HDA_SunNecklace"` then forced walk bench to window, pause about 40 ticks in | zoom 7, bench in front row off-centre, window light behind; floor items `HDA_NeckPlate`, `HDA_HeavyNeckArmor`, `HDA_Masochists_Choker` at angles; Shogun lies down facing the camera | item spawn, carries, forced walk, `lies down`, hide interface; base map | "The day starts with a necklace finished at dawn." |
| 2 | `2-morning-gift`, flower-garden, 08 Clear, +60 ticks | the Rose Necklace given to Soren; instant: just before he takes it; Nelim `carries the item "HDA_RoseNecklace"`, forced walk to Soren (about 25 ticks), Soren waits in place facing her | zoom 6, `HDA_LilyNecklace` on the ground in the foreground off-centre, the garden's own lilies and roses plus `Plant_Daylily` fully grown | item spawn, carries, forced walk, waits in place, decor | "A necklace for each of them, handed over among the flowers." |
| 3 | `3-tea-hut`, hut, 10 Clear, 1100 ticks | Soren in the Rose Necklace after the affinity settled, trait on the Character tab; instant: just before Nelim sets the meal down; Nelim `carries the item "MealSimple"`, forced walk to the table | zoom 9, pawns in the left two thirds, panel right; the hut's table and braseros, `TorchLamp` lit; Yuki kept asleep under the table | `Neck Accessory:` hediff 0.97 and wears, ticks, `I select the thing of def`, InspectTabs Character, decor lit | "The rose necklace has done its quiet work." |
| 4 | `4-noon-clearing`, bare-clearing, 12 Clear, +40 ticks | Soren carries the Heavy Neck Armor out of the clearing; instant: just before he puts it on; walk toward the camera, Nelim two cells behind, Shogun and Yuki follow (`follows`) | zoom 6, wide, group off-centre on the bared floor; flower border, `Plant_Daylily` fully grown, `PlantPot_Bonsai`; dogs seen from the front | carries, forced walk, follows, bare floor, decor | "He carries the heavy armour out to try it." |
| 5 | `5-afternoon-infirmary`, infirmary-pawns, 15 Clear, 6100 ticks | Soren with stiff shoulders, Nelim brings the Swindler's Necklace; instant: just before relief; `Neck Accessory:` StiffShoulder 0.5, Nelim carries `HDA_SwindlerNecklace`, forced walk to him, Health tab open | zoom 6, tight, beds and vitals monitors behind; Yuki asleep at the door | hediff step, carries, forced walk, select, InspectTabs Health, kept asleep | "The swindler's necklace eases what the armour stiffened." |
| 6 | `6-night-bridge`, river-bridge, 22 Clear, 60 ticks then 20 | Nelim in the Sun Necklace (Legendary), the light pool on her cell; instant: walking home, day done; wear, 60 ticks, forced walk south, pause after 20 | zoom 7, light against blue night, telescope in frame; Shogun ahead and Yuki behind both facing the camera | `Neck Accessory:` wears of quality, forced walk, follows, faces | "Walking home, a small sun around her neck." |

Interface windows, no subtitle, not scored: W1 info card of `HDA_Heros_scarf` (Stats tab), W2 info card of `HDA_Masochists_Choker`, both on `window-backdrop-for-height`, cropped.

Estimates (points only): 1 to 5 each 4.5 (j weak: a one-cell item is about 10 px at 268 px), 6 is 5. Weak points and risks: cells of the items and pawns not fixed (read on the empty photographs of each place before the ticket); the Soren and Nelim looks to check in `LOOKS-VALIDATION.md`; Soren's Gay trait on the Character tab of scene 3 confirmed by Virginie in the chat on 2026-11-02 ("ok"); sun-light pool brightness at 22:00 unplayed. Written 2026-11-02: `Tests/Pickle/Mod/Pickle/Features/04-gallery-captures.feature` (header = this shotlist, 6 scenes and 2 windows, `Check-Steps` resolves every line), pass map `Tests/Pickle/wsl-deps.gallery.map` with the seeds in `Tests/Pickle/config/gallery/`, subtitles in `PUBLICATION.md`. Cells are first guesses from the empty photographs, tuned by the first capture. Not filed: a ticket over about 5 scenarios is killed (exit 137), so the series goes in two or three tickets (`-Filter` on the image names).

### NSB - sync 2026-11-12

Places read: 2026-11-12 (git log since 2026-11-10: only the docs to Docs folder rename 18abf53, no content change; earlier read 2026-11-10: VALIDE.md places table and git log since 2026-11-02; SANCTUAIRE-LIEUX.md only through its diff, 1677380: no place of this mod touched) Tribe read: 2026-11-12 (log only, rename, no content change; earlier read 2026-11-10: VALIDE.md colonist and animal sections, APPARENCES-CANON.md lines of Nelim, Soren, Shogun, Yuki; profiles not reopened) Steps read: 2026-11-12 (PickleTools log since 2026-11-10: filth removal, floors terrain catalogue, decor burns, hide-tab-bar step, plant pot near a cell, thought stage text; none changes a step the six scenes call, none serves a shot; earlier: log since 2026-11-02: new steps are the field family, stockpile, sky overlays, cardinal-cell decor, graphic scale; none serves a shot of this mod).

Rules of the owner (2026-11-05, 2026-11-06, 2026-11-07), as applied: everything in NSB is free (places, colonists, domestic animals); outside NSB needs her express validation (colonist, domestic animal), none is used; a colonist property change needs her validation (one: Soren's Gay trait on the Character tab of scene 3, "ok" in the chat 2026-11-02, quoted in the shotlist section); every outfit is free; every animal the mod includes is in the gallery (the mod ships no animal: none to show).

Changed in NSB since 2026-11-02: places validated or refused in lots 5l and 5m (workshops, right-bank, left-bank, gravel-yard), fixture `Nelims-tribe-decor-mods-z3.rws` copied to `Mod/Pickle/Fixtures` (2026-11-09), Quill eyes in the roster. Nothing the gallery uses moved: updated none, files untouched. Left alone: Soren's daily outfit in NSB was redone on 2026-11-05 (`LisaWork_ApparelCollaredShirt` and vest), while this gallery keeps the blue-grey `Apparel_CollarShirt` of the shotlist: an outfit is free, the shotlist says which and why.

| Place | Shots | Changes for the gallery | Last read |
| --- | --- | --- | --- |
| `preindustrial-workshop` | 1 | none (validated 2026-11-07, lot 4a) | 2026-11-10 |
| `flower-garden` | 2 | none (revalidated 2026-11-07) | 2026-11-10 |
| `hut` (alias `tea-room`) | 3 | none (validated 2026-11-06); TorchLamp placed by the scene | 2026-11-10 |
| `bare-clearing` | 4 | none (validated 2026-11-07) | 2026-11-10 |
| `infirmary-pawns` | 5 | none (validated 2026-11-05) | 2026-11-10 |
| `river-bridge` | 6 | none (validated 2026-11-06; stepping stones removed lot 5m, outside the frame) | 2026-11-10 |

| Colonist | Shots | Outfit per shot | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| Nelim | 1 to 6 | teal `Apparel_BasicShirt` dyed (30, 100, 110) over the fixture trousers and corset, all day (continuity of one working day) | 2026-11-10 (VALIDE.md, APPARENCES-CANON.md) | none |
| Soren | 2 to 5 | blue-grey `Apparel_CollarShirt` (110, 130, 150), brown trousers, `Roo_HD_Hair_Tidy`, `Eyes_SkyBlue`; the necklaces for men are worn by him | 2026-11-10 (VALIDE.md, APPARENCES-CANON.md) | Gay trait granted by the mod's own mechanism, scene 3 Character tab: Virginie, chat, 2026-11-02, "ok" |

| Animal | Shots | Outfit | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| Shogun (labrador, linked to Nelim) | 1, 4, 6 | none | 2026-11-10 (VALIDE.md, APPARENCES-CANON.md) | none |
| Yuki (husky, linked to Soren) | 3, 4, 5, 6 | none | 2026-11-10 (VALIDE.md, APPARENCES-CANON.md) | none |

| Animal included by the mod | Shots |
| --- | --- |
| none (the mod adds eight neck accessories, no animal) | n/a |

### Plan score - 2026-11-10 (score-gallery, rules of 2026-11-07, plan only, one capture opened)

Plan confidence per scene: 1 = 4.5, 2 = 4.5, 3 = 4.0, 4 = 4.5, 5 = 4.0, 6 = 5.0 (mean 4.42). k (series) ok: one day, wide (4, 6), medium (1, 2, 3), close (5), opening 1, closing 6, hours move on. Weak points: j on 1, 2, 3, 4, 5 (a carried or floor necklace is about 10 px at 268 px; the worn piece draws nothing; the Character and Health tabs show a trait and a hediff, not the mod); g on 3 and 5 (the sentence "has done its quiet work" and "eases what the armour stiffened" is true only through the header). Gate "no ticket below 5" NOT met for scenes 1 to 5: ticket 91d2 (images 1 to 3) was filed under the old 4.0 floor; no ticket for images 4 to 6 until the plan is reworked: tighter crop (zoom 9 or more on the carried piece, about 30 px at 268 px) and, for 3 and 5, a visible object that says the sentence (the necklace carried in frame, the pawn's pose). Also: the header says Nelim wears charcoal trousers `Apparel_Pants`, the table above says the fixture trousers and corset: align at the rework.

Capture opened: image 3 of run f501 (deleted since): image 3.5, adequacy 2.5 (zoom 9 and Character tab absent, Nelim outside the door instead of carrying the meal in), understanding 2, decoration 3.5: REDO. Images 1 and 2 had no capture (scenario failed). Not verified: the 268 px reduction (no capture left), scenes 4 to 6 on image.

### Next steps and owner rules - 2026-10-27

When ticket 20261027-012303-669-87b8 is green: write `code_review_sha` (HEAD, bare 40-character sha; only STATUS, docs and Preview changed since `5f5c3d9`), then move to `shootGallery[1.0.0]` (8.n: `Check-Status`, `Mark-ProtocolsRead`, STATUS, commit, push, rename, `STAGE` message to the TM). Virginie approved the move in the chat (2026-10-27) on condition of a clean review; she chose to fix only the high finding. At `shootGallery`: run `write-shotlist` first, then `review-gallery`. Owner rules for the gallery (2026-10-27): any missing step is asked of NPT, and on a refusal Virginie arbitrates; only the colonists of NSB (SanctuaryBacklot) are allowed, any other colonist needs her express and reasoned authorization.

### Preview validated - 2026-10-27

Preview re-rendered from the new `Art/Preview.config.json` with `node ../scripts/Render-Preview.cjs bottom-left` (ModIcon badge bottom-left, 896x504, 526,2 KB, looked at). **Validated by Virginie in the chat on 2026-10-27**, revision `8ba8178`. `Art/Gallery/0-preview.png` is a byte copy. The corner is in the config (`icon.corner: bottom-left`), so a plain `node ../scripts/Render-Preview.cjs` gives the same image. The GitHub social preview is not re-uploaded (`social_preview_sha256`, due at writeDocs).

### Read on 2026-10-27 (both runs dated 2026-10-16, exitReason `passed`)

- Initial French retry (`Tests/Pickle/Evidence/initial-French-dc7ab9f`, set `sans-facultatifs`): 23/23 passed. Both initial passes (English and French) are green: the playTests criterion of done holds.
- `split-attraction` refiled after the Split Attraction support (`Tests/Pickle/Evidence/split-attraction-fix-English-61097be`): 10/10 passed, the four failed scenarios now green. All three optional passes (`sexualite`, `rimpsyche`, `split-attraction`) are green.
- Tested tree: both runs were played on 2026-10-16, after the last code commit (`61097be`, 2026-10-15 22:55); only STATUS.md, Preview and docs changed since, so the green results hold for the current `Mod/` and `Source/`. Every scenario of both runs ends with "no errors were logged": the log check (8.i) rests on that. No `@wip`, no `@review`, no `@requires` in the three features.
- Evidence pruned on 2026-10-27 (`Prune-Evidence.ps1 -Apply`): 7 superseded folders and 2 failed ones deleted, 2 kept minified with a `RELEASE.md` condition (`initial-French-dc7ab9f`, `split-attraction-fix-English-61097be`), about 36 KB in all.

## Passes and trait fix - 2026-10-14

Owner decisions in the chat. The necklaces now take back the Gay trait only when they gave it (`538da7a`: pawn ids kept in `NeckAccessoryMapComponent`, saved with the game; a pawn who already had the trait keeps it). Scenario 4 of `02` earns the trait as a man then unwinds it as a woman; a new scenario 5 is the control (an innate trait survives). Three optional passes were added (`Tests/Pickle/wsl-deps.sexualite.map`, `split-attraction`, `rimpsyche`; `TESTING.md`, "Passes"), exclusive where the mods declare themselves incompatible. Tickets: initial English `20261014-100025-201-4468`, initial French `20261014-100025-724-8e59`, and `20261014-165256-901-d07c` (sexualite), `20261014-165257-989-4055` (split-attraction), `20261014-165259-216-d300` (rimpsyche). They carry no sha: they stage the tree as it is when played (`130bb36` or later). The optional passes run filtered to the rose, lily and thought scenarios.

## Code review - 2026-10-14

Review by an independent read-only agent of Source/, Mod/Defs, Mod/Patches and the language folders at bfab278 (0 blocking, 4 risks, 2 questions). Fixed at d0cd3f7: the hero aura now reaches only the wearer's faction (it hit neutral factions, guests and animals), and the Japanese override of the vanilla Disfigured stage label was removed. The other findings are in remaining. The two initial Pickle tickets were filed at bfab278 and carry no sha: they stage the tree as it stands when played, so they test d0cd3f7 (or later), not bfab278. code_review_sha is not written yet (due at shootGallery, after the Pickle passes).

## Translation audit - ChatGPT review validated, 2026-11-12

Virginie validated the review in the chat on 2026-11-12 ("je valide la review"). Pass 1 (revision e435215): 5 applied at `b2831cf` (French hero stage and `nice_guy-0`, three missing Japanese descriptions), refusals in `Docs/review-refusals.md`. Pass 2 on the frozen text: no correction. `translation_fr` stays `complete`.

## Translation audit - French review, 2026-10-14

Reviewer: Virginie (confirmed in the chat). Revision reviewed: `4796eae` (the French files did not change between it and the audit of 2026-10-13). Corrections requested, all applied at `018b2cf`: "héros" replaced by neutral wording in five texts (HDA_Hediff_Hero_inspirationt label, the stage "Tant qu'il reste de l'héroïsme, je ne me vois pas perdre !", HDA_Heros_scarf label and description, HeroIsOnlyOne label). The description of the inspiration hediff also said "l'écharpe du héros": it became "l'écharpe héroïque" for consistency (a sixth text she did not list). Rose and lily necklaces confirmed correct (fixed sex, not an agreement). **Validated by Virginie in the chat on 2026-10-14** ("Je valide", revision `018b2cf`): the five reworded texts and the fixed-sex rose and lily wording; `translation_fr` is `complete`. The sixth text (inspiration description) was covered by her validation of the regenerated file. English defects reported, left uncorrected (see `remaining`).

## Audit — 2026-10-13

Previous state: `l10n` (old vocabulary, stage `done`). Retained after the owner's decisions of the same day: `workflow_stage: writeTests[1.0.0]` (first written as `makeSources`, see the waiver below). Revision audited: `477dbb5`
plus the local changes committed with this audit. The chain is replayed against the current protocols (AUDIT.md section 16);
independent validations of later states are kept and listed. No game was launched.

| Transition | Result |
| --- | --- |
| setupRepo -> makeSources | Passed: standalone repository `vbardales/Rimworld-Neck-Accessory` (public), README, ATTRIBUTION, LICENSE, CHANGELOG, `remote` field added, `(unofficial)` suffix and UNOFFICIAL paragraph present, `upstream_mod_remotes: N/A`. Upstream permission not rechecked live. |
| makeSources -> code | **Passed after two owner decisions on 2026-10-13** (first found blocked). 2.a: `Art/ModIcon-source.png` (the mascot) and `Art/Preview-source.png` are present. 2.b/2.c: `Mod/About/ModIcon.png` was stale (necklace-only, 14.9 KB); regenerated from the source on 2026-10-13 at the owner's request (128x128, 22,824 bytes, looked at), `modIconSource` added to `Art/Preview.config.json`. 2.e: `Measure-Palette.sh` on the source gives 1 hue family but Vmean 0.272 (< 0.30). The object is identifiable, no readable face, nothing standing upright (looked at). 2.d: no `PROMPT_*.md`. 2.f: the config named a missing `echo.png`: it now points at `Art/echo-preview.png`, the pre-gallery echo name of STYLE_RIMWORLD.md (it becomes `echo-source.png` at `mountPreview`); `Art/ModIcon-before-mascot.png` deleted once the icon was regenerated. |
| code -> declareDependencies | Passed: `Build-Mod.ps1 -Check` 0 warnings, 0 errors, `Mod/Assemblies/NeckAccessory.dll` and the Pickle steps DLL SAME as the sources. `CHANGELOG.md` heading is now `## [Unreleased]`, with a `[0.1.0] - 2026-10-01` entry (the item `3811292051` exists, `PublishedFileId.txt` is committed). No `feature` left in `remaining`. |
| declareDependencies -> settings | Passed on the 2026-09-13 audit, re-checked today: no Harmony, no mod reference in `Source/`, `Mod/Defs`, `Mod/Patches`; `About.xml` has no `modDependencies`, `loadAfter` lists vanilla and the DLCs, no `LoadFolders.xml`. |
| settings -> localize | Passed: `settings_audit: not_applicable`; today's search of `Source/`, `Mod/Defs`, `Mod/Patches` finds no ModSettings, SettingsCategory or MainButton, so no empty page and no shortcut. |
| localize -> writeTests | Passed: `Check-DefInjected.ps1` 148 keys, 0 errors; `Check-Translations.ps1` PASS, 59 source texts, with one WARN (see `remaining`). No text or Def changed since `4796eae`, so the 2026-09-30 reading for gender agreement and `FRENCH_REVIEW.md` still describe the shipped French; that reading was not redone today. |
| writeTests -> playTests | Blocked by 7.g: `translation_fr` is `partial` until Virginie reviews the French. Otherwise: `Tests/Test-Mod.ps1` rerun, 25 passed, 0 failed (it moved from `_tools/`); scenarios and the pass matrix are in `TESTING.md` (not named `TEST_SCENARIOS.md`); the Pickle suite is written, not played; the `LOCAL_SCRIPTS.md` row follows the move. |
| later states | Not reached. |

Changes made by this audit: the mod root is clean (`_tools/` moved to `Tests/`, the generator copy replaced by the shared
`scripts/Make-FrenchReview.ps1`, `build/` back as the build folder through `Directory.Build.props`, `Art/Preview-original.png`
and the gallery duplicate `00-preview.png` deleted); `Mod/About/About.xml` no longer names a RimWorld version in its description and
the `<author>` line uses `Udon - 1.6 adapted by Nelim`; the Preview was re-rendered (`node ../scripts/Render-Preview.cjs`, 896x504,
535,556 bytes, looked at) with its `Art/Gallery/0-preview.png` copy. The older "decision" paragraphs below stay as history and are
replaced by this one. `tested_1_7` is absent (not a defect).

**Waiver, 2026-10-13 (owner, in the chat):** the owner accepts `Art/Preview-source.png` at Vmean 0.272 (floor 0.30), the object being identifiable at 268 px; the source is not touched. The icon was regenerated from `Art/ModIcon-source.png` the same day.

Next work for the next transition only: Virginie reviews the French (`FRENCH_REVIEW.md`, 7.g), then the Pickle suite is played in `playTests`.

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
