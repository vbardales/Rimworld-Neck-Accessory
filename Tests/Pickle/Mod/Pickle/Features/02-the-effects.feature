# The effects, which nothing but a running map can show: in 1.6 worn apparel is never ticked, so the whole
# mechanism rests on NeckAccessoryMapComponent walking the pawn list, and a broken component leaves every
# piece silently inert with no error at load. Each scenario therefore has a control that must NOT change.
#
# A colonist is drafted the moment it is in place: a free colonist walks away, and the aura and the
# distances stop measuring the mod.
#
# The waits are the pieces' own intervals: 30 ticks (sun), 1000 (scarf, flower necklaces), 3000 (heavy
# armour), 6000 (swindler's). Ticks run in fast mode, so a wait costs seconds of real time.
Feature: the pieces do what they promise

  Background:
    Given the save "test-colony" is loaded
    And game speed is ultrafast

  # Heavy neck armour grinds the shoulders down; shoddy work bites hardest (Awful is x3).
  Scenario: heavy neck armour stiffens the shoulders of its wearer, and only its wearer
    Given a colonist "Bearer" exists
    And a colonist "Bystander" exists
    And I draft "Bearer"
    And I draft "Bystander"
    And Neck Accessory: "Bearer" wears "HDA_HeavyNeckArmor" of quality "Awful"
    When Neck Accessory: I let 3100 ticks pass
    Then Neck Accessory: the hediff "StiffShoulder" of "Bearer" has a severity above 0
    And Neck Accessory: the hediff "StiffShoulder" of "Bystander" has a severity of at most 0
    And no errors were logged

  # The swindler's necklace eases the stiffness. Awful work has a factor of 0: it must do nothing at all.
  Scenario: the swindler's necklace eases stiff shoulders, and shoddy work does not
    Given a colonist "Legendary" exists
    And a colonist "Awful" exists
    And I draft "Legendary"
    And I draft "Awful"
    And Neck Accessory: "Legendary" is given the hediff "StiffShoulder" at severity 0.5
    And Neck Accessory: "Awful" is given the hediff "StiffShoulder" at severity 0.5
    And Neck Accessory: "Legendary" wears "HDA_SwindlerNecklace" of quality "Legendary"
    And Neck Accessory: "Awful" wears "HDA_SwindlerNecklace" of quality "Awful"
    When Neck Accessory: I let 6100 ticks pass
    Then Neck Accessory: the hediff "StiffShoulder" of "Legendary" has a severity of at most 0.49
    And Neck Accessory: the hediff "StiffShoulder" of "Awful" has a severity of at least 0.49
    And no errors were logged

  # The rose necklace is for men: worn by one it builds an affinity, and settles it as a trait at 1.
  Scenario: a man in the rose necklace builds the affinity and settles it as a trait
    Given a colonist "Wearer" exists
    And "Wearer" gender is male
    And I draft "Wearer"
    And Neck Accessory: "Wearer" is stripped of the trait "Gay"
    And Neck Accessory: "Wearer" is given the hediff "InvitationForForbiddance" at severity 0.97
    And Neck Accessory: "Wearer" wears "HDA_RoseNecklace" of quality "Normal"
    When Neck Accessory: I let 1100 ticks pass
    Then Neck Accessory: the hediff "InvitationForForbiddance" of "Wearer" has a severity of at least 1
    And Neck Accessory: "Wearer" has the trait "Gay"
    And no errors were logged

  # Worn by the other sex it unwinds, and takes the trait back with it.
  Scenario: a woman in the rose necklace unwinds the affinity and loses the trait
    Given a colonist "Wearer" exists
    And "Wearer" gender is female
    And I draft "Wearer"
    And Neck Accessory: "Wearer" is given the trait "Gay"
    And Neck Accessory: "Wearer" is given the hediff "InvitationForForbiddance" at severity 0.03
    And Neck Accessory: "Wearer" wears "HDA_RoseNecklace" of quality "Normal"
    When Neck Accessory: I let 1100 ticks pass
    Then Neck Accessory: the hediff "InvitationForForbiddance" of "Wearer" has a severity of at most 0
    And Neck Accessory: "Wearer" does not have the trait "Gay"
    And no errors were logged

  Scenario: a woman in the lily necklace builds the affinity and settles it as a trait
    Given a colonist "Wearer" exists
    And "Wearer" gender is female
    And I draft "Wearer"
    And Neck Accessory: "Wearer" is stripped of the trait "Gay"
    And Neck Accessory: "Wearer" is given the hediff "InvitationForForbiddance" at severity 0.97
    And Neck Accessory: "Wearer" wears "HDA_LilyNecklace" of quality "Normal"
    When Neck Accessory: I let 1100 ticks pass
    Then Neck Accessory: "Wearer" has the trait "Gay"
    And no errors were logged

  # The sun necklace drops a light on its wearer every 30 ticks; each one lives 30 ticks, so the trail ends
  # the moment the necklace comes off.
  Scenario: the sun necklace lights the wearer's cell, and the light goes when it comes off
    Given a colonist "Bearer" exists
    And I draft "Bearer"
    And Neck Accessory: "Bearer" wears "HDA_SunNecklace" of quality "Normal"
    When Neck Accessory: I let 60 ticks pass
    Then Neck Accessory: a sun light stands on the cell of "Bearer"
    When Neck Accessory: "Bearer" takes off "HDA_SunNecklace"
    And Neck Accessory: I let 100 ticks pass
    Then Neck Accessory: no sun light remains on the map
    And no errors were logged

  # The scarf heartens allies within fifteen tiles: one at four cells gets the hediff, one at forty-two
  # does not, and the wearer does not heart-en itself.
  Scenario: the hero's scarf heartens the allies in range and none beyond it
    Given a colonist "Hero" exists
    And a colonist "Near" exists
    And a colonist "Far" exists
    And I draft "Hero"
    And I draft "Near"
    And I draft "Far"
    And Neck Accessory: "Hero" stands near x=142 z=155
    And Neck Accessory: "Near" stands near x=146 z=155
    And Neck Accessory: "Far" stands near x=100 z=155
    And Neck Accessory: "Hero" wears "HDA_Heros_scarf" of quality "Normal"
    When Neck Accessory: I let 1050 ticks pass
    Then Neck Accessory: the hediff "HDA_Hediff_Hero_inspirationt" of "Near" has a severity above 0.1
    And Neck Accessory: the hediff "HDA_Hediff_Hero_inspirationt" of "Far" has a severity of at most 0
    And Neck Accessory: the hediff "HDA_Hediff_Hero_inspirationt" of "Hero" has a severity of at most 0
    And no errors were logged
