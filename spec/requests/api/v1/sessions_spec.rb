require "rails_helper"

RSpec.describe API::V1::Sessions, type: :request do
  let(:user) { create(:user) }
  let(:params) { { email: user.email, password: "password" } }
  let(:action) { post api("/sessions"), params: params }
  subject { response }

  before do
    action
  end

  describe "POST /sessions" do
    context "when credentials are valid" do
      it { is_expected.to have_http_status(:created) }
      it { is_expected.to have_content_type("application/json") }

      it "has access_token" do
        expect(json_response).to have_key("access_token")
        expect(json_response["access_token"]).to eq(user.access_token)
      end
    end

    context "when email is missing" do
      let(:params) { { password: "password" } }

      it { is_expected.to have_http_status(:bad_request) }
    end

    context "when password is missing" do
      let(:params) { { email: user.email } }

      it { is_expected.to have_http_status(:bad_request) }
    end

    context "when email does not exist" do
      let(:params) { { email: "foo", password: "bar" } }

      it { is_expected.to have_http_status(:bad_request) }
    end

    context "when password is incorrect" do
      let(:params) { { email: user.email, password: "qwerty" } }

      it { is_expected.to have_http_status(:bad_request) }
    end
  end

  describe "DELETE /sessions/:access_token" do
    let(:access_token) { user.access_token }
    let(:action) { delete api("/sessions/#{access_token}") }

    context "when token is valid" do
      it { is_expected.to have_http_status(:ok) }
    end

    context "when token is invalid" do
      let(:access_token) { "foobar" }

      it { is_expected.to have_http_status(:bad_request) }
    end
  end
end
