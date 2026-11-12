# STEP PREFIXES: "Nelim's Sanctuary:" is the Sanctuary Backlot (fixture and named places); "Nelim's Pickle Tools:" is PickleTools
# (ScreenshotStudio presentation mode, ColonistRace clothes and forced jobs, CameraZoom, InspectTabs, StageDecor); "Neck Accessory:"
# is this mod's own steps; the rest is Pickle's.
#
# THE SERIES (GALLERY.md: staged photographs except the menus; one story; the session directs it). Shotlist of 2026-11-02, rated 4.5
# on its plan (STATUS.md, "Shotlist - 2026-11-02"); this header is its copy. Nothing is played yet: every cell below is read off the
# empty photographs of SanctuaryBacklot/Art/Locations (about 42 px per cell at zoom 8.5 on a 720 px high picture) and is a first guess,
# tuned by the first capture, never by the run being green.
#
# WHAT THE MOD CAN SHOW: nothing is drawn on a worn piece (no worn texture, README, "Known limitations"). Every scene therefore shows the
# mod by a carried or floor item (the icon of the piece), the sun-light pool at night, or an inspect tab of the pawn it works on.
#
# THE STORY, "a day of necklaces". One working day of Nelim, the only colonist of the Sanctuary, testing the neck pieces she made.
# Soren (the male alter ego, the one man of every male capture, SanctuaryBacklot/docs/GALERIE.md) is the only guest and wears the
# pieces made for men. Rhythm: one hour per image, 06, 08, 10, 12, 15, then 22 (the night jump is on purpose: the sun necklace needs the
# dark), each scenario sets its own hour. Clear sky, 20 degrees (no sweat on the faces).
# Outfits, the same all day (continuity, criterion d): Nelim a teal shirt Apparel_BasicShirt (30, 100, 110) over charcoal trousers
# Apparel_Pants (58, 58, 66), canon high ponytail Roo_HD_Hair_Highpony, her own face, MouthSmile with LidCheerful (smiling is the default
# on a default scene, GALLERY.md 2026-10-25); the teal is chosen so the gold of the sun necklace stands out. Soren the canon look of
# SanctuaryBacklot/docs/APPARENCES-CANON.md: Apparel_CollarShirt (110, 130, 150), Apparel_Pants (110, 80, 55), Roo_HD_Hair_Tidy, hair
# rgb (40, 28, 22), eyes Eyes_SkyBlue, MouthSmile. Only NSB colonists: Nelim and Soren. Dogs: Shogun (Labrador) and Yuki (Husky).
#
# HOW A GESTURE IS OBTAINED: the game is paused; a pawn is forced to walk (`is forced to walk to`) or carries an item, then
# `I advance the paused game by exactly N ticks` lets the walk begin and stops it mid-stride (about 13 ticks per cell). Pawns are placed
# AFTER every long wait, and wait in place while ticks run. The effects that need time run first, at ultrafast speed, then the game is paused.
# FACING: z grows to the north and the camera looks from the south, so a pawn or a dog walking to a SMALLER z shows its front.
#
# SHOOTING PLAN (place; hour; subject; instant; composition; living things; decor; what the image says):
#   1. OPENING, medium. preindustrial-workshop; 06:00 Clear, +60 ticks; Nelim carries the Sun Necklace (HDA_SunNecklace) from the
#      benches towards the open floor, mid-stride (forced walk from (225, 240) to (225, 238), 30 ticks); instant: "just polished, about to
#      try it on"; zoom 7 on (223, 238), the benches along the north wall behind her, torches lit; Shogun lies down facing South
#      beside her at (222, 238); decor on the floor in front of the benches, off the line: HDA_NeckPlate (222, 242),
#      HDA_HeavyNeckArmor (224, 241), HDA_Masochists_Choker (226, 243); says "the day starts with a necklace finished at dawn".
#   2. MEDIUM. flower-garden; 08:00, +60 ticks; Nelim carries the Rose Necklace (HDA_RoseNecklace) and walks to Soren at (154, 100), he
#      waits in place facing West, instant: "just before he takes it"; zoom 6 on (153, 101); HDA_LilyNecklace on the ground in the foreground
#      at (151, 98) off-centre; the garden's own lilies and roses, plus Plant_Daylily fully grown at (150, 99) and (156, 98); says "a
#      necklace for each of them, handed over among the flowers".
#   3. MEDIUM, tab. hut; 10:00, 1100 ticks of ultrafast first; Soren wears the Rose Necklace after the affinity settled (hediff
#      InvitationForForbiddance 0.97, then 1100 ticks: the trait Gay is granted); Soren at (135, 70) selected, the Character tab open;
#      Nelim carries a meal (MealSimple) in from the south door (141, 66) to (142, 69), mid-step, 20 ticks; instant: "just before she sets
#      the meal down"; zoom 9 on a cell shifted 4 cells west of the pawns so they sit in the right of the frame (the inspect panel is at
#      the left, GALERIE.md); Yuki kept asleep under the table at (139, 69) seen from the front; TorchLamp lit at (143, 74); the hut's own
#      table and braseros; says "the rose necklace has done its quiet work".
#   4. WIDE. bare-clearing; 12:00, +40 ticks; Soren carries the Heavy Neck Armor (HDA_HeavyNeckArmor) out of the clearing walking
#      South from (196, 156) to (196, 149), Nelim two cells behind him from (195, 158), Shogun and Yuki follow Nelim, all four seen from
#      the front; instant: "just before he puts it on"; zoom 6 on (195, 152); the clearing's flower border, Plant_Daylily fully grown at
#      (188, 155) and (203, 148), PlantPot_Bonsai at (190, 148); says "he carries the heavy armour out to try it".
#   5. CLOSE, tab. infirmary-pawns; 15:00, 6100 ticks of ultrafast first; Soren stands at (201, 51) with stiff shoulders (StiffShoulder 0.5
#      given), selected, the Health tab open; Nelim walks to him carrying the Swindler's Necklace (HDA_SwindlerNecklace) from (205, 51)
#      to (203, 51), 25 ticks; instant: "just before relief"; zoom 6 on a cell shifted 3 cells west of Soren; the room's beds and vital
#      monitors behind; Yuki kept asleep at the door (202, 48); says "the swindler's necklace eases what the armour stiffened".
#   6. CLOSING, wide. river-bridge; 22:00 Clear, 60 ticks then 20; Nelim in the Sun Necklace (Legendary), the light pool on her cell,
#      caught mid-stride eastwards across the wooden deck (x 127 to 141, z 123 to 127) from (131, 125) to (137, 125); instant: "walking
#      home, day done"; zoom 7 on (134, 125); Shogun sits ahead at (136, 124) facing South, Yuki follows Nelim; PlantPot_Bonsai at
#      (128, 128) and (139, 122) on the banks, unlit; says "a small sun around her neck, walking home".
#   W1 INTERFACE. the information card of HDA_Heros_scarf (Stats tab) on `window-backdrop-for-height`, cropped around the window afterwards,
#      no subtitle (not rated).
#   W2 INTERFACE. the information card of HDA_Masochists_Choker (Stats tab), same backdrop, same crop, no subtitle (not rated).
#
# SHOTLIST SCORE (GALLERY.md k, per shot a to g and j): see STATUS.md, "Shotlist - 2026-11-02".
# Review scenario: asserts each capture was taken, not what is on it. Each capture has to be OPENED AND LOOKED AT (AUDIT.md 9.d).
#
#   -Language English -DepMap wsl-deps.gallery.map -Filter '04-gallery-captures'
@requires:nelim.sanctuarybacklot
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.inspecttabs
@requires:nelim.pickletools.screenshotmode
@requires:nelim.pickletools.coatsteps
Feature: the Workshop gallery images

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (30, 100, 110)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (58, 58, 66)
    And Nelim's Pickle Tools: a colonist "Soren" of kind "Colonist" exists
    And Nelim's Pickle Tools: "Soren" gender is Male
    And Nelim's Pickle Tools: "Soren" head type is "Male_AverageNormal"
    And Nelim's Pickle Tools: "Soren" hair colour is rgb (40, 28, 22)
    And Nelim's Pickle Tools: "Soren" skin colour is rgb (236, 204, 184)
    And Nelim's Pickle Tools: "Soren" has the gene "Eyes_SkyBlue"
    And Nelim's Pickle Tools: "Soren" hairstyle is "Roo_HD_Hair_Tidy"
    And Nelim's Pickle Tools: "Soren" wears "Apparel_CollarShirt" dyed rgb (110, 130, 150)
    And Nelim's Pickle Tools: "Soren" wears "Apparel_Pants" dyed rgb (110, 80, 55)

  @review
  Scenario: image 1, Nelim carries the sun necklace across the workshop at dawn
    Given I set the hour to 6
    And Nelim's Sanctuary: the animals are removed from the sanctuary "preindustrial-workshop"
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And I wait 60 ticks
    When Nelim's Pickle Tools: I place the decor "HDA_NeckPlate" at (222, 242)
    And Nelim's Pickle Tools: I place the decor "HDA_HeavyNeckArmor" at (224, 241)
    And Nelim's Pickle Tools: I place the decor "HDA_Masochists_Choker" at (226, 243)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (222, 238)
    And Nelim's Pickle Tools: the animal "Shogun" lies at (222, 238) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (225, 240) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" carries the item "HDA_SunNecklace" made of "Gold"
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (225, 238)
    And Nelim's Pickle Tools: I advance the paused game by exactly 30 ticks
    And Nelim's Pickle Tools: I frame the cell (224, 240) at zoom 4.5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 1, the day starts with a necklace finished at dawn"
    And Nelim's Pickle Tools: the decor is removed
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: image 2, a necklace for each of them, handed over among the flowers
    Given I set the hour to 8
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    And I wait 60 ticks
    When Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (150, 99) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (156, 98) fully grown
    And Nelim's Pickle Tools: I place the decor "HDA_LilyNecklace" at (151, 98)
    And Nelim's Pickle Tools: "Soren" stands at (154, 100) facing West
    And Nelim's Pickle Tools: "Nelim" stands at (150, 101) facing East
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Soren" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" carries the item "HDA_RoseNecklace" made of "Gold"
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (153, 100)
    And Nelim's Pickle Tools: "Soren" waits in place
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (152, 100) at zoom 4.5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 2, a necklace for each of them"
    And Nelim's Pickle Tools: the decor is removed
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: image 3, the rose necklace has done its quiet work, the trait on the Character tab
    Given I set the hour to 10
    And game speed is ultrafast
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hut"
    And Nelim's Sanctuary: I am at the sanctuary "hut"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" stands at (135, 70) facing East
    And Nelim's Pickle Tools: "Soren" waits in place
    And Neck Accessory: "Soren" is stripped of the trait "Gay"
    And Neck Accessory: "Soren" is given the hediff "InvitationForForbiddance" at severity 0.97
    And Neck Accessory: "Soren" wears "HDA_RoseNecklace" of quality "Normal"
    When Neck Accessory: I let 1100 ticks pass
    Then Neck Accessory: "Soren" has the trait "Gay"
    Given game speed is paused
    When Nelim's Pickle Tools: I place the decor "TorchLamp" at (143, 74)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (143, 74) is lit
    And Nelim's Pickle Tools: the animal "Yuki" stands at (139, 69)
    And Nelim's Pickle Tools: the animal "Yuki" is kept asleep
    And Nelim's Pickle Tools: "Soren" stands at (135, 70) facing East
    And Nelim's Pickle Tools: "Soren" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" stands at (141, 66) facing North
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" carries the item "MealSimple"
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (142, 69)
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I select the thing of def "Human" at (135, 70)
    And Nelim's Pickle Tools: I open the "Character" inspect tab
    And Nelim's Pickle Tools: I frame the cell (136, 70) at zoom 5
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And I take a screenshot "image 3, the rose necklace has done its quiet work"
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  @review
  Scenario: image 4, Soren carries the heavy armour out of the clearing
    Given I set the hour to 12
    And Nelim's Sanctuary: the animals are removed from the sanctuary "bare-clearing"
    And Nelim's Sanctuary: I am at the sanctuary "bare-clearing"
    And I wait 60 ticks
    When Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (188, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (203, 148) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (190, 148)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (193, 156)
    And Nelim's Pickle Tools: the animal "Yuki" stands at (197, 157)
    And Nelim's Pickle Tools: "Soren" stands at (196, 156) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (195, 158) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Soren" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Soren" carries the item "HDA_HeavyNeckArmor" made of "Steel"
    And Nelim's Pickle Tools: "Soren" is forced to walk to (196, 149)
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (195, 151)
    And Nelim's Pickle Tools: "Shogun" follows "Nelim"
    And Nelim's Pickle Tools: "Yuki" follows "Nelim"
    And Nelim's Pickle Tools: I advance the paused game by exactly 40 ticks
    And Nelim's Pickle Tools: I frame the cell (195, 152) at zoom 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 4, he carries the heavy armour out to try it"
    And Nelim's Pickle Tools: the decor is removed
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: image 5, the swindler's necklace eases what the armour stiffened, the Health tab
    Given I set the hour to 15
    And game speed is ultrafast
    And Nelim's Sanctuary: the animals are removed from the sanctuary "infirmary-pawns"
    And Nelim's Sanctuary: I am at the sanctuary "infirmary-pawns"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" stands at (201, 51) facing South
    And Nelim's Pickle Tools: "Soren" waits in place
    And Neck Accessory: "Soren" is given the hediff "StiffShoulder" at severity 0.5
    And Neck Accessory: "Soren" wears "HDA_SwindlerNecklace" of quality "Legendary"
    When Neck Accessory: I let 6100 ticks pass
    Then Neck Accessory: the hediff "StiffShoulder" of "Soren" has a severity of at most 0.49
    Given game speed is paused
    When Nelim's Pickle Tools: the animal "Yuki" stands at (202, 48)
    And Nelim's Pickle Tools: the animal "Yuki" is kept asleep
    And Nelim's Pickle Tools: "Soren" stands at (201, 51) facing South
    And Nelim's Pickle Tools: "Soren" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" stands at (205, 51) facing West
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" carries the item "HDA_SwindlerNecklace" made of "Gold"
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (203, 51)
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I select the thing of def "Human" at (201, 51)
    And Nelim's Pickle Tools: I open the "Health" inspect tab
    And Nelim's Pickle Tools: I frame the cell (199, 52) at zoom 6
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And I take a screenshot "image 5, the swindler's necklace eases what the armour stiffened"
    Then no errors were logged

  @review
  Scenario: image 6, a small sun around her neck, walking home across the bridge at night
    Given I set the hour to 22
    And game speed is ultrafast
    And Nelim's Sanctuary: the animals are removed from the sanctuary "river-bridge"
    And Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (131, 125) facing East
    And Nelim's Pickle Tools: "Nelim" waits in place
    And Neck Accessory: "Nelim" wears "HDA_SunNecklace" of quality "Legendary"
    When Neck Accessory: I let 60 ticks pass
    Then Neck Accessory: a sun light stands on the cell of "Nelim"
    Given game speed is paused
    When Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (128, 128)
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (139, 122)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (136, 124)
    And Nelim's Pickle Tools: the animal "Shogun" faces South
    And Nelim's Pickle Tools: the animal "Yuki" stands at (129, 124)
    And Nelim's Pickle Tools: "Nelim" stands at (131, 125) facing East
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (137, 125)
    And Nelim's Pickle Tools: "Yuki" follows "Nelim"
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (134, 125) at zoom 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 6, a small sun around her neck"
    And Nelim's Pickle Tools: the decor is removed
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: window 1, the information card of the hero's scarf on the tall-window backdrop
    Given I set the hour to 12
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Sanctuary: the animals are removed from the sanctuary "window-backdrop-for-height"
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And I wait 120 ticks
    When Nelim's Pickle Tools: I place the decor "HDA_Heros_scarf" at (90, 140)
    And Nelim's Pickle Tools: I select the thing of def "HDA_Heros_scarf" at (90, 140)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "window 1, information card of the hero's scarf"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I close the info card
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  @review
  Scenario: window 2, the information card of the masochist's choker on the tall-window backdrop
    Given I set the hour to 12
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Sanctuary: the animals are removed from the sanctuary "window-backdrop-for-height"
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And I wait 120 ticks
    When Nelim's Pickle Tools: I place the decor "HDA_Masochists_Choker" at (90, 140)
    And Nelim's Pickle Tools: I select the thing of def "HDA_Masochists_Choker" at (90, 140)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "window 2, information card of the masochist's choker"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I close the info card
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged
