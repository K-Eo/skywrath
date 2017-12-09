module Shared
  module Components
    include Spinach::DSL

    step "I should see default nav" do
      assert_selector "nav#main-nav"
    end

    step "I should see settings sidebar" do
      assert_selector "#settings-sidebar"
      assert_selector "#settings-sidebar .nav-link[href='#{settings_profile_path}']",
                      text: "Perfil"
      assert_selector "#settings-sidebar .nav-link[href='#{settings_account_path}']",
                      text: "Cuenta"
      assert_selector "#settings-sidebar .nav-link[href='#{settings_email_path}']",
                      text: "Email"
    end

    def assert_flash(message, type = "success")
      within ".flash.messages" do
        assert_message message, type
      end
    end

    def assert_message(message, type = "success")
      assert_selector ".alert.alert-#{type}", text: message
    end

    def avatar(email)
      hash = Digest::MD5.hexdigest(email)
      "https://www.gravatar.com/avatar/#{hash}"
    end

    def profile_card(name, email, phone, new_user = false)
      assert_selector ".card"
      assert_selector ".card img[src^='#{avatar(email)}']"

      if new_user
        assert_selector ".card .card-title", text: email
      else
        assert_selector ".card .card-title", text: name
        assert_selector ".card .card-text dd", text: email
        assert_selector ".card .card-text dd", text: phone
      end
    end
  end
end
