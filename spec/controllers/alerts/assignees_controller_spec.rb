require "rails_helper"

RSpec.describe Alerts::AssigneesController, type: :controller do
  let(:user) { create(:user) }
  let(:alert) { create(:alert, assignee: nil) }
  subject { response }

  before do
    sign_in(user) if user
    post :create, params: { alert_id: alert.id }, xhr: true
  end

  describe "POST create" do
    context "when logged in" do
      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template("alerts/assignees/create") }

      it "responds javascript content" do
        expect(response.content_type).to eq("text/javascript")
      end

      it "sets current user as assignee" do
        alert.reload
        expect(alert.assignee).to eq(user)
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
