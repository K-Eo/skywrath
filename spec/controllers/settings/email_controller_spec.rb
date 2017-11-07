require "rails_helper"

RSpec.describe Settings::EmailController, type: :controller do
  subject { response }
  let(:user) { create(:user) }
  let(:action) { -> {} }

  before do
    sign_in user if user
    action
  end

  describe "GET #show" do
    let(:action) { get :show }

    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:show) }

      it "assigns user" do
        expect(assigns(:user)).to eq(user)
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe "GET #update" do
    let(:params) { { user: { email: "foo@bar.com" } } }
    let(:action) { patch :update, params: params }

    context "when logged in" do
      context "when params are valid" do
        it { is_expected.to redirect_to(settings_email_path) }

        it "sets flash" do
          expect(flash[:success]).to match("Recibirás un email con las instrucciones")
        end

        it "saves changes" do
          user.reload
          expect(user.unconfirmed_email?).to be_truthy
          expect(user.unconfirmed_email).to eq("foo@bar.com")
        end

        it "assigns user" do
          expect(assigns(:user)).to eq(user)
        end
      end

      context "when params are invalid" do
        let(:params) { { user: { email: "" } } }

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to render_template(:show) }

        it "does not change user email" do
          user.reload
          expect(user.unconfirmed_email?).to be_falsey
          expect(user.unconfirmed_email).to be_nil
        end

        it "assigns user" do
          expect(assigns(:user)).to eq(user)
        end
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
