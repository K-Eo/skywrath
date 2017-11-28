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

    context "when logged out" do
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

      it "returns object" do
        expect(json_response["created_at"]).not_to be_nil
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

  describe "POST /alerts/:alert_id/assign" do
    let(:alert) { create(:alert, assignee: nil) }
    let(:action) { post api("/alerts/#{alert.id}/assign", user) }

    context "when logged in" do
      it { is_expected.to have_http_status(:created) }

      it "assigns current user as assignee" do
        alert.reload
        expect(alert.assignee).to eq(user)
      end
    end

    context "when logged out" do
      let(:user) { nil }
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe "PATCH /alerts/:alert_id/close" do
    let(:alert) { create(:alert, assignee: user) }
    let(:action) { patch api("/alerts/#{alert.id}/close", user) }

    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }

      it "changes alert state to closed" do
        alert.reload
        expect(alert.state).to eq("closed")
        expect(alert.closed_at).not_to be_nil
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
