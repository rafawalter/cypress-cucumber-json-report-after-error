Feature: Mdn Web Docs throws an error

  Scenario: the page throws an error
    Given I visit web docs
    # breaks on the step above, since
    When I click "Run"
    Then I get an error in the console

  Scenario: error after origin change
    Given I open Kitchen Sink
    And I visit web docs using javascript
    # breaks on the step above, since
    When I click "Run"
    Then I get an error in the console
