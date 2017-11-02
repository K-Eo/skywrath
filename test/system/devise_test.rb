require "application_system_test_case"

class DeviseTest < ApplicationSystemTestCase
  include Support::AuthLinks

  test "visiting landing page" do
    visit root_path

    assert_selector ".hero", text: "Skywrath Project"
    sign_in_link
    sign_up_link
  end

  test "visiting sign up page" do
    visit new_user_registration_path

    within "form#new_user" do
      assert_selector "input#user_email"
      assert_selector "input#user_password"
      assert_selector "input#user_password_confirmation"
      assert_selector "input[type=submit]"
    end

    sign_in_link
    confirmation_link
    unlock_link
  end

  test "visiting sign in page" do
    visit new_user_session_path

    within "form#new_user" do
      assert_selector "input#user_email"
      assert_selector "input#user_password"
      assert_selector "input[type=submit]"
    end

    sign_up_link
    forgot_password_link
    confirmation_link
    unlock_link
  end

  test "visiting forgot password page" do
    visit new_user_password_path

    within "form#new_user" do
      assert_selector "input#user_email"
      assert_selector "input[type=submit]"
    end

    sign_in_link
    sign_up_link
    confirmation_link
    unlock_link
  end

  test "visiting confirmations page" do
    visit new_user_confirmation_path

    within "form#new_user" do
      assert_selector "input#user_email"
      assert_selector "input[type=submit]"
    end

    sign_in_link
    sign_up_link
    forgot_password_link
    unlock_link
  end

  test "visiting unlock_link" do
    visit new_user_unlock_path

    within "form#new_user" do
      assert_selector "input#user_email"
      assert_selector "input[type=submit]"
    end

    sign_in_link
    sign_up_link
    forgot_password_link
    confirmation_link
  end
end
