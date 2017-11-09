require "rails_helper"

RSpec.describe API::Helpers::Common, type: :helper do
  let(:email) { "foo@bar" }
  let(:hash) { Digest::MD5.hexdigest(email) }
  subject { avatar(email) }

  context "when email is present" do
    it { is_expected.to match(%{https://www.gravatar.com/avatar/#{hash}?s=80&d=retro}) }
  end

  context "when email is nil" do
    let(:email) { nil }

    it { is_expected.to eq("") }
  end
end
