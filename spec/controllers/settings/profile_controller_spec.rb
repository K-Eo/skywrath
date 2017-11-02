require 'rails_helper'

RSpec.describe Settings::ProfileController, type: :controller do
  subject { response }
  let(:user) { create(:user) }
  let(:action) { -> {} }

  before do
    sign_in user if user
    action
  end

  describe "GET show" do
    let(:action)  do
      get :show
    end

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

  describe "PATCH update" do
    let(:params) do
      { user: { name: "Foo Bar", phone: "9876665432" } }
    end

    let(:action) do
      patch :update, params: params
    end

    context "when logged in" do
      context "when params are valid" do
        it { is_expected.to redirect_to(settings_profile_path) }

        it "sets a flash message" do
          expect(flash[:success]).to eq("Perfil actualizado")
        end

        it "commits changes" do
          user.reload
          expect(user.name).to eq("Foo Bar")
          expect(user.phone).to eq("9876665432")
        end
      end

      context "when params are invalid" do
        let(:params) do
          { user: { name: "", phone: "foobar" } }
        end

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to render_template(:show) }

        it "does not change user" do
          user.reload
          expect(user.name).to_not eq("Foo Bar")
          expect(user.phone).to_not eq("9876665433")
        end
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
