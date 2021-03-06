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

  Scenario: Filtering records by identifier
    Given I have created these records:
      | gmail.com    | work     |
      | gmail.com    | personal |
      | facebook.com | personal |
    When I run "list gmail.com"
    Then I see:
      """
      work/gmail.com
      personal/gmail.com
      """

  Scenario: Filtering records by category
    Given I have created these records:
      | gmail.com    | work     |
      | gmail.com    | personal |
      | facebook.com | personal |
    When I run "list personal"
    Then I see:
      """
      personal/gmail.com
      personal/facebook.com
      """

  Scenario: Filtering records by identifier and category
    Given I have created these records:
      | gmail.com    | work     |
      | gmail.com    | personal |
      | facebook.com | personal |
    When I run "list personal/gmail.com"
    Then I see:
      """
      personal/gmail.com
      """
