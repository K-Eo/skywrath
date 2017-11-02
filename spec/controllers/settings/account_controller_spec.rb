require 'rails_helper'

RSpec.describe Settings::AccountController, type: :controller do
  subject { response }
  let(:user) { create(:user) }
  let(:action) { -> {} }

  before do
    sign_in user if user
    action
  end

  describe "GET show" do
    let(:action) { get :show }

    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:show) }

      it "assigns user" do
        expect(assigns(:user)).to eq(user)
      end

      it "responds with html" do
        expect(subject.content_type).to eq("text/html")
      end
    end

    context "when logged out" do
      let(:user)  { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe "PATCH update" do
    let(:action) { patch :update, params: params }
    let(:params) do
      {
        user: {
          current_password: "password",
          password: "qwerty",
          password_confirmation: "qwerty"
        }
      }
    end

    context "when logged in" do
      context "when params are valid" do
        it { is_expected.to redirect_to(settings_account_path) }

        it "sets a flash message" do
          expect(flash[:success]).to eq("Contraseña actualizada")
        end

        it "assigns user" do
          expect(assigns(:user)).to eq(user)
        end
      end

      context "when params are invalid" do
        let(:params) do
          {
            user: {
              current_password: "qwerty",
              password: "foo",
              password_confirmation: "bar"
            }
          }
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to render_template(:show) }

        it "does not set a flash message" do
          expect(flash[:success]).to be_nil
        end
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe "DELETE destroy" do
    context "when logged in" do
      let(:action) { -> {} }

      it "redirects to root" do
        delete :destroy
        is_expected.to redirect_to(root_path)
      end

      it "destroys user" do
        expect { delete :destroy }.to change { User.count }.by(-1)
      end
    end

    context "when logged out" do
      let(:action) { delete :destroy }
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
