require "rails_helper"

RSpec.describe Alert, type: :model do
  let(:user) { create(:user) }
  subject { build(:alert, author: user) }

  it { is_expected.to be_valid }

  describe "user" do
    context "when is not present" do
      let(:user) { nil }

      it { is_expected.to be_invalid }
    end
  end

  describe "#newest" do
    it "resturns newest first" do
      oldest = create(:alert, author: user, created_at: 2.minute.ago)
      newest = create(:alert, author: user, created_at: 1.minute.ago)

      expect(Alert.newest.all).to eq([newest, oldest])
    end
  end
end
