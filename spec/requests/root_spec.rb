require 'rails_helper'

RSpec.describe "Root", type: :request do
  let(:user) { create(:user) }
  let(:action) { get dashboard_path }

  subject { response }

  before do
    sign_in(user) if user
    action
  end

  describe "GET /dashboard" do
    context "when logged in" do
      it { is_expected.to redirect_to(alerts_path) }
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
