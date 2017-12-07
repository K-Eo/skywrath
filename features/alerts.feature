Feature: Alerts
  Background:
    Given User "Mia Volkova" exists
    And I sign in as user

  Scenario: I should see alerts
    And I have one alert
    When I visit alerts page
    Then I should see one alert
    And I should not see alerts paginator

  Scenario: I should see alerts paginator
    And I have 30 alerts
    When I visit alerts page
    Then I should see 20 alerts
    And I should see alerts paginator

  Scenario: I should see no alerts message
    And I have no alerts
    When I visit alerts page
    Then I should not see alerts
    And I should see blank slate
