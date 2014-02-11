Feature: New Command

  Scenario: Input identifier, category, and password
    Given I run "new"
    Then I answer these questions:
      | Identifier? | myidentifier |
      | Category?   | mycategory   |
      | Password?   | mysecret     |
      | Password (again)? | mysecret |
    Then I have this record:
      | identifier | myidentifier |
      | category   | mycategory   |
      | secret     | mysecret     |

  Scenario: Input password only
    Given I run "new identifier=myidentifier category=mycategory"
    Then I answer these questions:
      | Password?         | mysecret |
      | Password (again)? | mysecret |
    Then I have this record:
      | identifier | myidentifier |
      | category   | mycategory   |
      | secret     | mysecret     |

  Scenario: Input password only (short version)
    Given I run "new mycategory/myidentifier"
    Then I answer these questions:
      | Password?         | mysecret |
      | Password (again)? | mysecret |
    Then I have this record:
      | identifier | myidentifier |
      | category   | mycategory   |
      | secret     | mysecret     |

  Scenario: Password don't match
    Given I run "new mycategory/myidentifier"
    When I answer these questions:
      | Password?         | mysecret    |
      | Password (again)? | notmysecret |
    Then I see text like "Passwords don't match." on stderr
