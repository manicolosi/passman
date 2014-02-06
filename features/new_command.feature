Feature: List Command

  Scenario: Empty database
    Given I create a new record
    When I answer the questions
    Then I have a record
