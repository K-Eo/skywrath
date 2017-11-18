require "rails_helper"

RSpec.describe "GraphQL", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "X-Access-Token" => user.access_token } }
  let(:action) { post "/graphql", headers: headers }

  subject { response }
  before { action }

  describe "POST #execute" do
    context "when access token is valid" do
      it { is_expected.to have_http_status(:ok) }
    end

    context "when access token is missing" do
      let(:headers) { {} }

      it { is_expected.to have_http_status(:bad_request) }
    end

    context "when access token is invalid" do
      let(:headers) { { "X-Access-Token" => "foobar" } }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
