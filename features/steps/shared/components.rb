module Shared
  module Components
    include Spinach::DSL

    step "I should see default nav" do
      assert_selector "nav#default"
      assert_selector "nav#default .header.item[href='/dashboard']"
      user_menu("nav#default", @user.name, @user.email)
    end

    def user_menu(parent, header, avatar)
      user_dropdown = "#{parent} .ui.right.dropdown.pointing.top.user.item#user_links"
      menu = "div.menu"

      assert_selector "#{user_dropdown}"
      assert_selector "#{user_dropdown} img[src^='#{avatar(avatar)}']"
      assert_selector "#{user_dropdown} #{menu} .header", text: header
      assert_selector "#{user_dropdown} #{menu} a.item[href='#{settings_profile_path}']"
      assert_selector "#{user_dropdown} #{menu} a.item[href='#{destroy_user_session_path}']"
    end

    step "I should see my profile card" do
      profile_card(@user.name, @user.email, @user.phone)
    end

    step "I should see my minimal profile card" do
      profile_card(@user.name, @user.email, @user.phone, true)
    end

    step "I should see settings sidebar" do
      assert_selector "#settings-sidebar"
      assert_selector "#settings-sidebar .header", text: "Opciones personales"
      assert_selector "#settings-sidebar .item.active", count: 1
      assert_selector "#settings-sidebar .item[href='#{settings_profile_path}']",
                      text: "Perfil"
      assert_selector "#settings-sidebar .item[href='#{settings_account_path}']",
                      text: "Cuenta"
    end

    def assert_flash(message, type = "success")
      within ".flash.messages" do
        assert_message message, type
      end
    end

    def assert_message(message, type = "success")
      assert_selector ".ui.message.#{type}", text: message
    end

    def avatar(email)
      hash = Digest::MD5.hexdigest(email)
      "https://www.gravatar.com/avatar/#{hash}"
    end

    def assert_paginator(id, present = true)
      selector = "nav.ui.pagination.menu"
      within(id) do
        if present
          assert_selector selector
        else
          assert_no_selector selector
        end
      end
    end

    def profile_card(name, email, phone, new_user = false)
      assert_selector ".ui.card .image img[src^='#{avatar(email)}']"
      if new_user
        assert_selector ".ui.card .header", text: email
      else
        assert_selector ".ui.card .header", text: name
        assert_selector ".ui.card .description p", text: email
        assert_selector ".ui.card .description p", text: phone
      end
    end
  end
end
