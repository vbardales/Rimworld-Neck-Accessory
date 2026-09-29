# What only a running game can say about the defs of Neck Accessory Renew.
#
# The offline suite (_tools/Test-Mod.ps1) proves the XML on its own: every extension class named in a
# def exists in the assembly, every hediff a piece names exists, the qualities line up with the sun
# lights. What it cannot see is the game as it loaded: the vanilla Disfigured thought after this mod's
# patch AND every other active mod's, and the pieces as ThingDefs the engine accepted.
Feature: the defs as the loaded game holds them

  Background:
    Given the save "test-colony" is loaded

  Scenario: the vanilla Disfigured thought carries this mod's worker and its extra stage
    Then Neck Accessory: the thought "Disfigured" uses the worker "NeckAccessory.ThoughtWorker_Disfigured_ProofOfHero" and has 2 stages
    And no errors were logged

  Scenario Outline: each piece is a def of the loaded game
    Then def "<piece>" of type "ThingDef" exists
    And no errors were logged

    Examples:
      | piece                 |
      | HDA_NeckPlate         |
      | HDA_HeavyNeckArmor    |
      | HDA_Heros_scarf       |
      | HDA_Masochists_Choker |
      | HDA_RoseNecklace      |
      | HDA_LilyNecklace      |
      | HDA_SwindlerNecklace  |
      | HDA_SunNecklace       |
