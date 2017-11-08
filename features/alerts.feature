Feature: Alerts
  Background:
    Given User "Mia Volkova" exists
    And I sign in as user

  Scenario: I should see alerts
    Given I have one alert
    When I visit alerts page
    Then I should see one alert
    And I should not see alerts paginator

  Scenario: I should see alerts paginator
    Given I have 30 alerts
    When I visit alerts page
    Then I should see 24 alerts
    And I should see alerts paginator
    And I click on next page
    And I should see 6 alerts

  Scenario: I should see no alerts message
    Given I have no alerts
    When I visit alerts page
    Then I should not see alerts
    And I should see no alerts message

  Scenario: I create alert
    Given I send one alert
    When I visit alerts page
    Then I should see one alert
