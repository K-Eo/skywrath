require "rails_helper"

RSpec.describe API::Helpers::Auth, type: :helper do
  let(:user) { create(:user) }
  let(:env) { { "warden" => war } }
  let(:head) { { "X-Access-Token" => "foo" } }
  let(:params) { { access_token: "bar" } }
  let(:authenticated) { false }
  let(:war) do
    war = Class.new do
      attr_accessor :authenticate

      def authenticated?
        authenticate
      end
    end
    war.new.tap { |o| o.authenticate = authenticated }
  end
  let(:request) do
    req = Class.new { attr_accessor :headers }.new
    req.headers = head
    req
  end

  def error!(message, code)
    raise "#{message} #{code}"
  end

  describe "#authenticate!" do
    subject { authenticate! }

    context "when is handle by devise" do
      let(:authenticated) { true }

      it "authenticates" do
        expect { subject }.not_to raise_error
      end
    end

    context "when access token as header is valid" do
      let(:head) { { "X-Access-Token" => user.access_token } }

      it "authenticates" do
        expect { subject }.not_to raise_error
      end
    end

    context "when access token as header is invalid" do
      let(:head) { { "X-Access-Token" => "foo" } }

      it "does not authenticate" do
        expect { subject }.to raise_error(/401 Unauthorized/)
      end
    end

    context "when access token as param is valid" do
      let(:head) { {} }
      let(:params) { { access_token: user.access_token } }

      it "authenticates" do
        expect { subject }.not_to raise_error
      end
    end

    context "when access token as param is invalid" do
      let(:head) { {} }
      let(:params) { { access_token: "foo" } }

      it "does not authenticate" do
        expect { subject }.to raise_error(/401 Unauthorized/)
      end
    end

    context "when both tokens are valid" do
      let(:head) { { "X-Access-Token" => user.access_token } }
      let(:params) { { access_token: user.access_token } }

      it "authenticates" do
        expect { subject }.not_to raise_error
      end
    end

    context "when both tokens are invalid" do
      let(:head) { { "X-Access-Token" => "foo" } }
      let(:params) { { access_token: "foo" } }

      it "does not authenticate" do
        expect { subject }.to raise_error(/401 Unauthorized/)
      end
    end

    context "when header is valid but param" do
      let(:head) { { "X-Access-Token" => user.access_token } }
      let(:params) { { access_token: "foo" } }

      it "authenticates" do
        expect { subject }.not_to raise_error
      end
    end

    context "when header is invalid but param" do
      let(:head) { { "X-Access-Token" => "foo" } }
      let(:params) { { access_token: user.access_token } }

      it "does not authenticate" do
        expect { subject }.to raise_error(/401 Unauthorized/)
      end
    end
  end
end
