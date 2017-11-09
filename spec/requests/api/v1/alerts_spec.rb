require "rails_helper"

RSpec.describe API::V1::Alerts, type: :request do
  let(:user) { create(:user) }
  let(:params) { {} }
  let(:action) { get api("/alerts", user) }
  let(:factory) {}

  subject { response }
  before { factory; action; }

  describe "GET /alerts" do
    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to have_content_type("application/json") }

      describe "body" do
        let(:factory) { create_list(:alert, 2, author: user) }
        subject { json_response }

        it "has alerts" do
          expect(subject.length).to be(2)
        end
      end
    end

    context "when logged in" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
