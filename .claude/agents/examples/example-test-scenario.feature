Feature: <Feature Name>
  As a <user type>
  I want <goal>
  So that <benefit>

  Background:
    Given <common precondition 1>
    And <common precondition 2>
    And <common precondition 3>

  Scenario: <Scenario 1 Name - Happy Path>
    Given <specific precondition>
    When <action performed>
    Then <expected result>
    And <additional verification>
    And <additional verification>

  Scenario: <Scenario 2 Name - Edge Case>
    Given <specific precondition>
    When <action performed>
    Then <expected result>
    And <additional verification>

  Scenario: <Scenario 3 Name - Error Handling>
    Given <specific precondition>
    When <error condition occurs>
    Then <error should be handled gracefully>
    And <appropriate error message displayed>
    And <system remains in consistent state>

  Scenario: <Scenario 4 Name - Performance>
    Given <specific precondition>
    When <action performed>
    Then <action completes within acceptable time>
    And <resource usage is acceptable>

  Scenario: <Scenario 5 Name - Integration>
    Given <multiple systems are involved>
    When <action that crosses boundaries>
    Then <all systems behave correctly>
    And <data consistency maintained>
