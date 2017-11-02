require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "gets index if not logged in" do
    get root_path
    assert_response :success
  end

  test "redirects to dashboard if logged in" do
    sign_in users(:eo)
    get root_path
    assert_redirected_to dashboard_path
  end
end
