Feature: List Command

  Scenario: Empty database
    Given I don't have an existing database
    When I run "list"
    Then I see no output

  Scenario: One record
    Given I have created this record:
      | myidentifier | mycategory |
    When I run "list"
    Then I see:
      """
      mycategory/myidentifier
      """

  Scenario: Multiple records
    Given I have created these records:
      | github.com   | dev      |
      | gmail.com    | personal |
      | facebook.com | social   |
    When I run "list"
    Then I see:
      """
      dev/github.com
      personal/gmail.com
      social/facebook.com
      """
