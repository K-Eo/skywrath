Feature: Alerts
  Background:
    Given User "Mia Volkova" exists
    And I sign in as user

  Scenario: I should see alerts
    Given I have one alert
    When I visit alerts page
    Then I should see one alert

  Scenario: I should see no alerts message
    Given I have no alerts
    When I visit alerts page
    Then I should see no alerts
    And I should see no alerts message


  Scenario: I create alert
    Given I send one alert
    When I visit alerts page
    Then I should see one alert
