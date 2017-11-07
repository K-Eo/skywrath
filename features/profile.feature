Feature: Profile
  Background:
    Given I sign in as user

  Scenario: I look at my profile
    When I visit profile page
    Then I should see my minimal profile card
    And I should see default nav
    And I should see user menu with email

  Scenario: I edit my profile
    Given I visit profile settings page
    Then I change my profile info
    And I should see "Perfil actualizado" alert
    And I visit profile page
    And I should see my new profile card

  Scenario: I unsuccessfully edit my profile
    Given I visit profile settings page
    Then I unsuccessfully change my profile info
    And I should see profile error messages

  Scenario: I change my password
    Given I visit account settings page
    Then I change my password
    And I should see password change alert

  Scenario: I unsuccessfully change my password
    Given I visit account settings page
    When I unsuccessfully change my password
    Then I should see a password error message

  Scenario: I change my email
    Given I visit email settings page
    When I change my email
    Then I should see email change alert
    And I should see email pending reconfirmation

  Scenario: I unsuccessfully change my email
    Given I visit email settings page
    When I unsuccessfully change my email
    Then I should see email error message

  @javascript
  Scenario: I close my account
    Given I visit account settings page
    When I click on delete my account
    Then I should be redirected to home page
