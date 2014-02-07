Feature: New Command

  Scenario: All values are asked
    Given I create a new record
    When I answer the questions
    Then I have a record
