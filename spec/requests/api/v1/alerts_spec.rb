require "rails_helper"

RSpec.describe API::V1::Alerts, type: :request do
  let(:user) { create(:user) }
  let(:params) { {} }
  let(:action) { get api("/alerts", user) }
  let(:factory) {}

  subject { response }
  before do |example|
    unless example.metadata[:skip_before]
      factory
      action
    end
  end

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

  describe "POST /alerts" do
    let(:action) { post api("/alerts", user) }

    context "when logged in" do
      it { is_expected.to have_content_type("application/json") }
      it { is_expected.to have_http_status(:created) }

      it "persists object", :skip_before do
        expect { action }.to change { Alert.count }.by(1)
      end

      it "alert has current user as author" do
        expect(Alert.last.author).to eq(user)
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }

      it "does not persists object", :skip_before do
        expect { action }.to change { Alert.count }.by(0)
      end
    end
  end
end
