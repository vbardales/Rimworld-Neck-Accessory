# The thoughts. Each ThoughtWorker is a situational state, so it can only be read on a pawn the game is
# simulating: the offline suite checks that the workers exist, not what they say about two colonists.
Feature: the pieces change how colonists feel

  Background:
    Given the save "test-colony" is loaded
    And game speed is ultrafast

  # Humiliating for almost everyone, a delight for a masochist: two thoughts, one worker.
  Scenario: the masochist's choker humiliates an ordinary wearer
    Given a colonist "Wearer" exists
    And Neck Accessory: "Wearer" is stripped of the trait "Masochist"
    And Neck Accessory: "Wearer" wears "HDA_Masochists_Choker" of quality "Normal"
    Then Neck Accessory: "Wearer" feels the mood thought "NormalsChorker" at stage 0
    And Neck Accessory: "Wearer" feels no mood thought "MasochistsChorker"
    And no errors were logged

  Scenario: the masochist's choker delights a masochist
    Given a colonist "Wearer" exists
    And Neck Accessory: "Wearer" is given the trait "Masochist"
    And Neck Accessory: "Wearer" wears "HDA_Masochists_Choker" of quality "Normal"
    Then Neck Accessory: "Wearer" feels the mood thought "MasochistsChorker" at stage 0
    And Neck Accessory: "Wearer" feels no mood thought "NormalsChorker"
    And no errors were logged

  Scenario: the sun necklace is a little dazzling, and worse for an undergrounder
    Given a colonist "Plain" exists
    And a colonist "Underground" exists
    And Neck Accessory: "Plain" is stripped of the trait "Undergrounder"
    And Neck Accessory: "Underground" is given the trait "Undergrounder"
    And Neck Accessory: "Plain" wears "HDA_SunNecklace" of quality "Normal"
    And Neck Accessory: "Underground" wears "HDA_SunNecklace" of quality "Normal"
    Then Neck Accessory: "Plain" feels the mood thought "SunNecklace" at stage 0
    And Neck Accessory: "Underground" feels the mood thought "SunNecklace" at stage 1
    And no errors were logged

  # A man in the rose necklace is liked by men (stage 0) and read differently by women (stage 1).
  Scenario: what others think of a man in the rose necklace depends on their sex
    Given a colonist "Wearer" exists
    And "Wearer" gender is male
    And a colonist "Brother" exists
    And "Brother" gender is male
    And a colonist "Sister" exists
    And "Sister" gender is female
    And Neck Accessory: "Wearer" wears "HDA_RoseNecklace" of quality "Normal"
    Then Neck Accessory: "Brother" holds the opinion thought "RoseNecklace" of "Wearer" at stage 0
    And Neck Accessory: "Sister" holds the opinion thought "RoseNecklace" of "Wearer" at stage 1
    And no errors were logged

  Scenario: what others think of a woman in the lily necklace depends on their sex
    Given a colonist "Wearer" exists
    And "Wearer" gender is female
    And a colonist "Sister" exists
    And "Sister" gender is female
    And a colonist "Brother" exists
    And "Brother" gender is male
    And Neck Accessory: "Wearer" wears "HDA_LilyNecklace" of quality "Normal"
    Then Neck Accessory: "Sister" holds the opinion thought "LilyNecklace" of "Wearer" at stage 0
    And Neck Accessory: "Brother" holds the opinion thought "LilyNecklace" of "Wearer" at stage 1
    And no errors were logged

  # There is room for only one hero: two scarves in one faction do not care for each other.
  Scenario: two wearers of the hero's scarf in one faction cannot stand each other
    Given a colonist "First" exists
    And a colonist "Second" exists
    And Neck Accessory: "First" wears "HDA_Heros_scarf" of quality "Normal"
    And Neck Accessory: "Second" wears "HDA_Heros_scarf" of quality "Normal"
    Then Neck Accessory: "First" holds the opinion thought "HeroIsOnlyOne" of "Second" at stage 0
    And no errors were logged
