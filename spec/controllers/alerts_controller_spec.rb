require "rails_helper"

RSpec.describe AlertsController, type: :controller do
  let(:user) { create(:user) }
  let(:action) { get :index }
  subject { response }

  before do
    sign_in(user) if user
    action
  end

  describe "GET #index" do
    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
