require "rails_helper"

RSpec.describe "User Edit", type: :request do
  describe "GET /sudo/edit" do
    it "redirects to settings/profile" do
      get edit_user_registration_path
      expect(response).to redirect_to(settings_profile_path)
    end
  end
end
