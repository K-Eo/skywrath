require "rails_helper"

class BootstrapModelTest
  include ActiveModel::Model
  attr_accessor :name
  attr_accessor :tos

  validates :name, presence: true

  def self.model_name
    ActiveModel::Name.new(self, nil, "Bootstrap")
  end
end

RSpec.describe FormHelper, type: :helper do
  let(:html) { nil }
  let(:resource) { BootstrapModelTest.new }
  let(:options) { { url: root_path, html: html } }
  subject do
    helper.bootstrap_form_for(resource, options) {}
  end

  describe "classes" do
    context "adds additional styling" do
      let(:html) { { class: "foo bar" } }

      it { is_expected.to match(/class="foo bar"/) }
    end
  end

  describe "#fields" do
    subject { @field }
    let(:args) { {} }
    let(:validate) { false }
    before do
      resource.valid? if validate
      helper.bootstrap_form_for(resource, options) do |f|
        @field = f.text_field :name, args
      end
    end

    describe "tags" do
      it { is_expected.to match(%{<div class="form-group">}) }
      it { is_expected.to match(%{<label for="bootstrap_name">Name</label>}) }
      it { is_expected.to match(%q{<input class="form-control" type="text" name="bootstrap\[name\]" id="bootstrap_name" />}) }
      it { is_expected.to match(%{</div>}) }
    end

    describe "helper" do
      let(:args) { { helper: "Some helper text" } }

      it { is_expected.to match(%{<small class="form-text text-muted">Some helper text</small>}) }
    end

    describe "label" do
      let(:args) { { label: "Label text" } }

      it { is_expected.to match(%{<label for="bootstrap_name">Label text</label>}) }
    end

    describe "error" do
      let(:validate) { true }
      let(:args) { { helper: "Some helper text" } }

      it { is_expected.to match(%{<div class="form-group">}) }
      it { is_expected.to match(%{<div class="invalid-feedback">no puede estar en blanco</div>}) }
      it { is_expected.to_not match(%{<small class="form-text text-muted">Some helper text</small>}) }
    end
  end

  describe "#check_box" do
    subject { @field }
    let(:args) { {} }

    before do
      helper.bootstrap_form_for(resource, options) do |f|
        @field = f.check_box :tos, args
      end
    end

    describe "tags" do
      it { is_expected.to match(%{<div class="form-check">}) }
      it { is_expected.to match(%q{input class="form-check-input"}) }
      it { is_expected.to match(%{label class="form-check-label" for="bootstrap_tos"}) }
    end
  end

  describe "#submit" do
    subject { @field }
    let(:args) { {} }

    before do
      helper.bootstrap_form_for(resource, options) do |f|
        @field = f.submit args
      end
    end

    describe "tags" do
      it { is_expected.to match(%{<div class="form-group">}) }
      it { is_expected.to match(%{input type="submit"}) }
      it { is_expected.to match(%{class="btn btn-primary"}) }
      it { is_expected.to_not match(%{block="}) }

      context "block" do
        let(:args) { { block: true } }

        it { is_expected.to match(%{class="btn btn-primary btn-block"}) }
        it { is_expected.to_not match(%{block="}) }
      end
    end
  end
end
