Feature: New Command

  Scenario: Test
    Given I run "new" and answer these questions:
      | Identifier? | myidentifier |
      | Category?   | mycategory   |
      | Password?   | mysecret     |
    When I run "dump myidentifier"
    Then I see something like this:
      """
      identifier: myidentifier
      category:   mycategory
      secret:     mysecret
      """
