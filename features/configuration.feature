Feature: Configuration

  Scenario Outline: Initial configuration
    Given I don't have a configuration file
    When I run "<command>"
    Then I see text like "Installing initial configuration" on stderr

    Examples:
      | command      |
      | copy foo/bar |
      | databases    |
      | dump         |
      | edit-all     |
      | list         |
      | new mycategory/myidentifier --no-password |
      | print        |
