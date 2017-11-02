require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }
  subject { response }

  describe "#GET show" do
    before do
      sign_in(user) unless user.nil?
      get :show
    end

    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
