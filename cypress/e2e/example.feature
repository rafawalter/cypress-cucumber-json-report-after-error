Feature: Example Feature

  Scenario: Visit the homepage
    Given I open the homepage
    Then I see the title "Kitchen Sink"

  Scenario: throws an error
    Given I open the homepage
    And I throw an error
