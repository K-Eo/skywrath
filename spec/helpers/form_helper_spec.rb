require 'rails_helper'

class SemanticModelTest
  include ActiveModel::Model
  attr_accessor :name
  attr_accessor :tos

  validates :name, presence: true

  def self.model_name
    ActiveModel::Name.new(self, nil, "Semantic")
  end
end

RSpec.describe FormHelper, type: :helper do
  let(:html) { nil }
  let(:resource) { SemanticModelTest.new }
  let(:options) { { url: root_path, html: html } }
  subject do
    helper.semantic_form_for(resource, options) {}
  end

  describe "classes" do
    context "adds semantic styling" do
      it { is_expected.to match(/class="ui form"/) }
    end

    context "adds additional styling" do
      let(:html) { { class: "foo bar" } }

      it { is_expected.to match(/class="ui form foo bar"/) }
    end
  end

  describe "#fields" do
    subject { @field }
    let(:args) { {} }
    let(:validate) { false }
    before do
      resource.valid? if validate
      helper.semantic_form_for(resource, options) do |f|
        @field = f.text_field :name, args
      end
    end

    describe "tags" do
      it { is_expected.to match(%{<div class="field">}) }
      it { is_expected.to match(%{<label for="semantic_name">Name</label>}) }
      it { is_expected.to match(%q{<input type="text" name="semantic\[name\]" id="semantic_name" />}) }
      it { is_expected.to match(%{</div>}) }
    end

    describe "helper" do
      let(:args) { { helper: "Some helper text" } }

      it { is_expected.to match(%{<span class="helper block">Some helper text</span>}) }
    end

    describe "label" do
      let(:args) { { label: "Label text" } }

      it { is_expected.to match(%{<label for="semantic_name">Label text</label>}) }
    end

    describe "error" do
      let(:validate) { true }
      let(:args) { { helper: "Some helper text" } }

      it { is_expected.to match(%{<div class="field error">}) }
      it { is_expected.to match(%{<span class="error block">no puede estar en blanco</span>}) }
      it { is_expected.to_not match(%{<span class="helper block">Some helper text</span>}) }
    end
  end

  describe "#check_box" do
    subject { @field }
    let(:args) { {} }

    before do
      helper.semantic_form_for(resource, options) do |f|
        @field = f.check_box :tos, args
      end
    end

    describe "tags" do
      it { is_expected.to match(%{<div class="field">}) }
      it { is_expected.to match(%{<div class="ui checkbox">}) }
      it { is_expected.to match(%q{input name="semantic\[tos\]"}) }
      it { is_expected.to match(%q{label for="semantic_tos"}) }
    end
  end

  describe "#submit" do
    subject { @field }
    let(:args) { {} }

    before do
      helper.semantic_form_for(resource, options) do |f|
        @field = f.submit args
      end
    end

    describe "tags" do
      it { is_expected.to match(%{<div class="field">}) }
      it { is_expected.to match(%{input type="submit"}) }
      it { is_expected.to match(%{class="ui positive button"}) }
      it { is_expected.to_not match(%{fluid="}) }

      context "fluid" do
        let(:args) { { fluid: true } }

        it { is_expected.to match(%{class="ui positive button fluid"}) }
        it { is_expected.to_not match(%{fluid="}) }
      end
    end
  end
end
