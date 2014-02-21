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
      | password   | mysecret     |

  Scenario: Input password only
    Given I run "new identifier=myidentifier category=mycategory"
    Then I answer these questions:
      | Password?         | mysecret |
      | Password (again)? | mysecret |
    Then I have this record:
      | identifier | myidentifier |
      | category   | mycategory   |
      | password   | mysecret     |

  Scenario: Input password only (short version)
    Given I run "new mycategory/myidentifier"
    Then I answer these questions:
      | Password?         | mysecret |
      | Password (again)? | mysecret |
    Then I have this record:
      | identifier | myidentifier |
      | category   | mycategory   |
      | password   | mysecret     |

  Scenario: Additional fields and short version
    Given I run "new mycategory/myidentifier username=foobar"
    Then I answer these questions:
      | Password?         | mysecret |
      | Password (again)? | mysecret |
    Then I have this record:
      | identifier | myidentifier |
      | category   | mycategory   |
      | password   | mysecret     |
      | username   | foobar       |

  Scenario: Password don't match
    Given I run "new mycategory/myidentifier"
    When I answer these questions:
      | Password?         | mysecret    |
      | Password (again)? | notmysecret |
    Then I see text like "Passwords don't match" on stderr

  Scenario: Blank fields
    Given I run "new"
    When I answer this question:
      | Identifier? | |
    Then I see text like "Fields cannot be blank" on stderr
