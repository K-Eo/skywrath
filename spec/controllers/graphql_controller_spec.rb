require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { email: user.email, password: "password" } }
  let(:action) { post :sign_in, params: params }

  subject { response }
  before { action }

  describe "POST #sign_in" do
    context "when params are present" do
      it { is_expected.to have_http_status(:ok) }

      it "returns access token" do
        expect(json_response["access_token"]).to eq(user.access_token)
      end
    end

    context "when params are blank" do
      let(:params) { {} }

      it { is_expected.to have_http_status(:bad_request) }
      it "returns error message" do
        expect(json_response["error"]).to eq("Missing params")
      end
    end

    context "when password is invalid" do
      let(:params) { { email: user.email, password: "foobar" } }

      it { is_expected.to have_http_status(:bad_request) }
      it "returns error message" do
        expect(json_response["error"]).to eq("Email or password invalid")
      end
    end

    context "when email does not exist" do
      let(:params) { { email: "foo@bar.com", password: "password" } }

      it { is_expected.to have_http_status(:bad_request) }

      it "returns error message" do
        expect(json_response["error"]).to eq("Email or password invalid")
      end
    end
  end

  describe "#DELETE sign_out" do
    let(:params) { { access_token: user.access_token } }
    let(:action) { delete :sign_out, params: params }

    context "when access token is valid" do
      it { is_expected.to have_http_status(:accepted) }

      it "returns success mesasge" do
        expect(json_response["message"]).to eq("Have a nice day!")
      end
    end

    context "when access token is invalid" do
      let(:params) { { access_token: "foobar" } }

      it { is_expected.to have_http_status(:bad_request) }

      it "returns error message" do
        expect(json_response["error"]).to eq("Bad request")
      end
    end

    context "when access token is missing" do
      let(:params) { {} }

      it { is_expected.to have_http_status(:bad_request) }

      it "returns error message" do
        expect(json_response["error"]).to eq("Bad request")
      end
    end
  end
end
