require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#active_link_to" do
    let(:name) { "Home" }
    let(:path) { "/foo" }
    let(:options) { nil }

    subject do
      helper.active_link_to(name, path, options)
    end

    it { is_expected.to match(%{<a href="/foo">Home</a>}) }

    describe "active" do
      before do
        allow(helper).to receive(:controller_name) { "foo" }
      end

      it { is_expected.to match(%{<a class="active" href="/foo">Home</a>}) }

      context "when has additional classes" do
        let(:options) { { class: "foo bar" } }

        it { is_expected.to match(%{<a class="foo bar active" href="/foo">Home</a>}) }
      end
    end

    describe "controller" do
      let(:options) { { controller: "test" } }

      it { is_expected.to match(%{<a class="active" href="/foo">Home</a>}) }

      context "when has additional classes" do
        let(:options) { { controller: "test", class: "foo bar" } }

        it { is_expected.to match(%{<a class="foo bar active" href="/foo">Home</a>}) }
      end
    end

    context "when has additional classes" do
      let(:options) { { class: "foo bar" } }

      it { is_expected.to match(%{<a class="foo bar" href="/foo">Home</a>}) }
    end
  end

  describe "#gravatar" do
    let(:object) { build(:user, name: nil, email: "foo@bar.com") }
    let(:options) { {} }

    subject do
      helper.gravatar(object, options)
    end

    it { is_expected.to match(%{<img alt="F" width="80" height="80" src="https://www.gravatar.com/avatar/f3ada405ce890b6f8204094deb12d8a8?d=retro&amp;s=80" />}) }

    context "when size is given" do
      let(:options) { { size: "120" } }

      it { is_expected.to match(%{<img alt="F" width="120" height="120" src="https://www.gravatar.com/avatar/f3ada405ce890b6f8204094deb12d8a8?d=retro&amp;s=120" />}) }
    end

    context "when display is given" do
      let(:options) { { display: "card" } }

      it { is_expected.to match(%{<img alt="F" width="80" height="80" src="https://www.gravatar.com/avatar/f3ada405ce890b6f8204094deb12d8a8?d=card&amp;s=80" />}) }
    end

    context "when has additional options" do
      let(:options) { { class: "avatar" } }

      it { is_expected.to match(%{<img class="avatar" alt="F" width="80" height="80" src="https://www.gravatar.com/avatar/f3ada405ce890b6f8204094deb12d8a8?d=retro&amp;s=80" />}) }
    end

    describe "alt" do
      let(:object) { build(:user, name: "Mia Volkova", email: "foo@bar.com") }

      context "when user has name" do

        it { is_expected.to match(%{<img alt="M" width="80" height="80" src="https://www.gravatar.com/avatar/f3ada405ce890b6f8204094deb12d8a8?d=retro&amp;s=80" />}) }
      end

      context "when is given" do
        let(:options) { { alt: "Alt text" } }

        it { is_expected.to match(%{<img alt="Alt text" width="80" height="80" src="https://www.gravatar.com/avatar/f3ada405ce890b6f8204094deb12d8a8?d=retro&amp;s=80" />}) }
      end
    end
  end
end
