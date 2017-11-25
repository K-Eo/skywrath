require "rails_helper"

RSpec.describe API::V1::Assists, type: :request do
  let(:alert) { create(:alert) }
  let(:user) { alert.author }
  let(:params) { {} }
  let(:action) { post api("/assists/#{alert.id}/assist", user) }
  let(:factory) {}

  subject { response }

  before do |example|
    unless example.metadata[:skip_before]
      factory
      action
    end
  end

  describe "POST /assists/:alert_id/assist" do
    context "when logged in" do
      it { is_expected.to have_http_status(:created) }
      it { is_expected.to have_content_type("application/json") }

      describe "body" do
        subject { json_response }

        it "updates alert state to assisting" do
          expect(subject["state"]).to eq("assisting")
          expect(subject["assisting_at"]).not_to be_nil
        end

        context "when state is assisting" do
          let(:alert) { create(:alert, state: "assisting") }

          it "respons with 406" do
            expect(response).to have_http_status(:not_acceptable)
          end

          it "does not update state to assisting" do
            alert.reload
            expect(alert.state).to eq("assisting")
            expect(alert.assisting_at).to be_nil
          end
        end
      end
    end
    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe "POST /assists/:alert_id/close" do
    let(:alert) { create(:alert, state: "assisting") }
    let(:action) { post api("/assists/#{alert.id}/close", user) }

    context "when logged in" do
      it { is_expected.to have_http_status(:created) }
      it { is_expected.to have_content_type("application/json") }

      describe "body" do
        subject { json_response }

        it "updates alert state to closed" do
          expect(subject["state"]).to eq("closed")
          expect(subject["closed_at"]).not_to be_nil
        end

        context "when state is closed" do
          let(:alert) { create(:alert, state: "closed") }

          it "respons with 406" do
            expect(response).to have_http_status(:not_acceptable)
          end
        end
      end
    end

    context "when logged out" do
      let(:user) { nil }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
