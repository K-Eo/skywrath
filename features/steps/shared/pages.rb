module Shared
  module Pages
    include Spinach::DSL

    step "I visit dashboard page" do
      visit dashboard_path
    end

    step "I should be redirected to dashboard" do
      expect(page.current_path).to eq(dashboard_path)
    end

    step "I should be redirected to home page" do
      expect(page.current_path).to eq(root_path)
    end

    step "I visit profile settings page" do
      visit settings_profile_path
    end

    step "I visit account settings page" do
      visit settings_account_path
    end
  end
end
