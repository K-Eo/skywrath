require "test_helper"

class Settings::ProfileControllerTest < ActionDispatch::IntegrationTest
  class Show < Settings::ProfileControllerTest
    def nuke
      @user = users(:eo)
      sign_in @user
      get settings_profile_path
    end

    test "responds with success" do
      nuke
      assert_response :success
    end

    test "renders default nav" do
      nuke
      assert_select "nav#default"
    end

    test "renders flash messages" do
      nuke
      assert_select ".flash.messages"
    end

    test "render content wraper" do
      nuke
      assert_select "#content-body"
    end

    test "renders settings sidebar" do
      nuke
      assert_select "#settings-sidebar" do
        assert_select "a.item.active", "Perfil"
      end
    end

    test "renders edit profile form" do
      nuke
      assert_select "#edit_user_#{@user.id}" do
        assert_select "#user_name[value='#{@user.name}']"
        assert_select "#user_phone[value='#{@user.phone}']"
        assert_select "input[type=submit]"
      end
    end

    test "redirects if not logged in" do
      get settings_profile_path
      assert_redirected_to new_user_session_path
    end
  end
end
