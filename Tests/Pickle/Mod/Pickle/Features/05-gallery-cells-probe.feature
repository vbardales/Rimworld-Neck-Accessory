# Probe, temporary: lists the free standable cells of the six places of the gallery (reads only), to fix the cells of 04-gallery-captures.feature.
# Delete after the ticket is read.
#   -Language English -DepMap wsl-deps.gallery.map -Filter '05-gallery-cells-probe'
@requires:nelim.sanctuarybacklot
@requires:nelim.pickletools.screenshotstudio
Feature: the free cells of the gallery places

  Scenario: cells of the workshop
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the free standable cells of the area from (216, 233) to (230, 245) are listed
    Then no errors were logged

  Scenario: cells of the garden
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the free standable cells of the area from (146, 93) to (158, 105) are listed
    Then no errors were logged

  Scenario: cells of the hut
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the free standable cells of the area from (133, 62) to (146, 76) are listed
    Then no errors were logged

  Scenario: cells of the clearing
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the free standable cells of the area from (186, 145) to (206, 160) are listed
    Then no errors were logged

  Scenario: cells of the infirmary
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the free standable cells of the area from (196, 44) to (208, 56) are listed
    Then no errors were logged

  Scenario: cells of the bridge
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the free standable cells of the area from (126, 120) to (142, 130) are listed
    Then no errors were logged
