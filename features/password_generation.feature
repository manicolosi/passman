Feature: List Command

  Scenario: Empty database
    Given I've configured the password generator
    When I create a new record without a password
    Then a password gets generated
