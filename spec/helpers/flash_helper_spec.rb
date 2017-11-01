require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  let(:key) { nil }
  subject do
    helper.normalize_flash(key)
  end

  context "when key is nil" do
    it { is_expected.to eq("info") }
  end

  context "when key is notice" do
    let(:key) { :notice }

    it { is_expected.to eq("success") }
  end

  context "when key is success" do
    let(:key) { :success }

    it { is_expected.to eq("success") }
  end

  context "when key is alert" do
    let(:key) { :alert }

    it { is_expected.to eq("error") }
  end

  context "when key is error" do
    let(:key) { :error }

    it { is_expected.to eq("error") }
  end

  context "when key is other" do
    let(:key) { :other }

    it { is_expected.to eq("other") }
  end

  context "when key is given as string" do
    let(:key) { "foobar" }

    it { is_expected.to eq("foobar") }
  end

  context "when key is not string or symbol" do
    let(:key) { ["foobar"] }

    it { is_expected.to eq("info") }
  end
end
