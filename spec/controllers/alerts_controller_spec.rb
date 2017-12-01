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
      it { is_expected.to render_template(:index) }

      it "assigns alerts" do
        expect(assigns(:alerts)).to_not be_nil
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe "POST #create" do
    let(:params) { {} }
    let(:action) { post :create, params: params, xhr: true }

    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template("alerts/create") }

      context "when saved" do
        let(:action) { -> {} }
        subject { post :create, params: params, xhr: true }

        it { expect { subject }.to change { Alert.count }.by(1) }
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
