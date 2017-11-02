require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  def nuke
    sign_in users(:eo)
    get dashboard_path
  end

  test "gets show if logged in" do
    nuke
    assert_response :success
    assert_select ".flash.messages"
  end

  test "renders default nav" do
    nuke
    assert_select "nav#default"
  end

  test "renders flash messages" do
    nuke
    assert_select ".flash.messages"
  end

  test "renders content wrapper" do
    nuke
    assert_select "#content-body"
  end

  test "redirects to new session if logged out" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end
end
