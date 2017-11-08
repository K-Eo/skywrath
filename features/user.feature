Feature: User
  Background:
    Given User "Mia Volkova" exists
    And I sign in as user

  Scenario: Sign in
    Then I should be redirected to alerts
    And I should see default nav

  Scenario: Visiting profile settings
    When I visit profile settings page
    Then I should see default nav
    And I should see settings sidebar
    And Sidebar profile item should be active

  Scenario: Visiting account settings
    When I visit account settings page
    Then I should see default nav
    And I should see settings sidebar
    And Sidebar account item should be active
