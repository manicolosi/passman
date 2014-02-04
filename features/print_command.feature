Feature: Print Command

  Scenario: One record
    Given I have created this record:
      | myidentifier | mycategory | mysecret |
    When I run "print myidentifier"
    Then I see:
      """
      mysecret
      """
