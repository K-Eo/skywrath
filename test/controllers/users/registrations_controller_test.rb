require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "edit redirects to settings/profile" do
    get edit_user_registration_path
    assert_redirected_to settings_profile_path
  end
end
