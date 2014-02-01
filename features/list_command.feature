Feature: List Command
  In order to see what records exist
  As a user
  I want to see a quick list of my records

  Scenario: Empty database
    Given I don't have an existing database
    When I run 'list'
    Then I see no output
