Feature: New Command

  Scenario: Input identifier, category, and password
    Given I run "new" and answer these questions:
      | Identifier? | myidentifier |
      | Category?   | mycategory   |
      | Password?   | mysecret     |
      | Password (again)? | mysecret |
    When I run "dump myidentifier"
    Then I see text like:
      """
      identifier: myidentifier
      category:   mycategory
      secret:     mysecret
      """

  Scenario: Input password only
    Given I run "new identifier=myidentifier category=mycategory" and answer this questions:
      | Password? | mysecret |
      | Password (again)? | mysecret |
    When I run "dump myidentifier"
    Then I see text like:
      """
      identifier: myidentifier
      category:   mycategory
      secret:     mysecret
      """

  Scenario: Input password only (short version)
    Given I run "new mycategory/myidentifier" and answer these questions:
      | Password?         | mysecret |
      | Password (again)? | mysecret |
    When I run "dump myidentifier"
    Then I see text like:
      """
      identifier: myidentifier
      category:   mycategory
      secret:     mysecret
      """

  Scenario: Passwords don't match
    Given I run "new mycategory/myidentifier" and answer these questions:
      | Password?         | mysecret    |
      | Password (again)? | notmysecret |
    Then I see text like "Passwords don't match." on stderr
