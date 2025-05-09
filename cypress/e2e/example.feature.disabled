Feature: Example Feature

  Scenario: Visit the homepage
    Given I open the homepage
    Then I see the title "Kitchen Sink"

  Scenario: throws an error
    Given I open the homepage
    And I throw an error

  Scenario: throws an error on another origin
    Given I open the homepage
    And I change the origin
    And I throw an error at another origin

  Scenario: throws an error inside the steps
    Given I open the homepage
    And I change the origin
    And I throw an error at another origin

#  @focus
  Scenario: throws an error after navigation to another origin
    Given I open the homepage
    Then I see the title "Kitchen Sink"
    When I click on the GitHub link
    Then I see the GitHub icon
    And I throw an error at another origin

  @focus
  Scenario: the page throws an error
    Given I visit web docs
    And I click "Run"
    Then I get an error in the console
