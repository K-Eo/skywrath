Feature: Alerts
  Background:
    Given User "Mia Volkova" exists
    And I sign in as user

  @javascript
  Scenario: I should see alerts
    Given I have one alert
    When I visit alerts page
    Then I should see one alert
    And I should not see alerts load more

  @javascript
  Scenario: I should see alerts paginator
    Given I have 30 alerts
    When I visit alerts page
    Then I should see 25 alerts
    And I should see alerts load more
    And I click on load more
    And I should see 30 alerts

  @javascript
  Scenario: I should see no alerts message
    Given I have no alerts
    When I visit alerts page
    Then I should not see alerts
    And I should see no alerts message

  @javascript
  Scenario: I create alert
    Given I send one alert
    Then I should see one alert

  @javascript
  Scenario: I should see alert details
    Given I have one alert
    When I visit alerts page
    And I visit alert details
    Then I should see open alert

  @javascript
  Scenario: I should close an alert
    Given I have one alert
    When I visit alerts page
    And I assignee myself
    And I visit alert details
    And I close the alert
    Then I should see closed alert
