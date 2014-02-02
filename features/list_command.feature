Feature: List Command

  Scenario: Empty database
    Given I don't have an existing database
    When I run 'list'
    Then I see no output

  Scenario: One record
    Given I have created a record
    When I run 'list'
    Then I see 'mycategory/myidentifier'
