require "rails_helper"

RSpec.describe TimeHelper, type: :helper do
  let(:target) { create(:alert) }
  let(:options) { nil }
  subject { helper.timeago(target.created_at, options) }

  describe "#timeago" do
    it { is_expected.to match(/<span .+><\/span>/) }
    it { is_expected.to match(/class="timeago"/) }
    it { is_expected.to match(/datetime="#{target.created_at}"/) }
    it { is_expected.to match(/title="#{target.created_at}"/) }

    context "when tag is given" do
      let(:options) { { tag: :div } }

      it { is_expected.to_not match(/<span .+><\/span>/) }
      it { is_expected.to match(/<div .+><\/div>/) }
    end

    context "when has additional classes" do
      let(:options) { { class: "foo bar" } }

      it { is_expected.to match(/class="timeago foo bar"/) }
    end

    context "when has additional options" do
      let(:options) { { id: "timeago" } }

      it { is_expected.to match(/id="timeago"/) }
    end
  end
end
