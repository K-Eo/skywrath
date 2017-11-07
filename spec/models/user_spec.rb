require "rails_helper"

RSpec.describe User, type: :model do
  let(:email) { "foo@bar.com" }
  let(:password) { "password" }
  let(:password_confirmation) { "password" }
  let(:name) { "Foo Bar" }
  let(:phone) { "9876665432" }
  let(:user) do
    build(:user, email: email,
                 password: password,
                 password_confirmation: password_confirmation,
                 name: name,
                 phone: phone)
  end

  subject { user }

  it { is_expected.to be_valid }

  it "should save" do
    expect(subject.save).to be_truthy
  end

  describe "email" do
    context "not present" do
      let(:email) { "" }

      it { is_expected.to be_invalid }
    end

    context "wrong format" do
      let(:email) { "foobar.com" }

      it { is_expected.to be_invalid }
    end

    context "email taken" do
      before { create(:user, email: "foo@bar.com") }

      it { is_expected.to be_invalid }
    end
  end

  describe "password" do
    context "not present" do
      let(:password) { "" }

      it { is_expected.to be_invalid }
    end
  end

  describe "password confirmation" do
    context "not present" do
      let(:password_confirmation) { "" }

      it { is_expected.to be_invalid }
    end

    context "not match with password" do
      let(:password_confirmation) { "foobar" }

      it { is_expected.to be_invalid }
    end
  end

  describe "#has_name?" do
    subject { user.has_name? }

    context "when name is present" do
      it { is_expected.to be_truthy }
    end

    context "when name is not present" do
      let(:name) { nil }
      it { is_expected.to be_falsey }
    end
  end

  describe "#update_profile" do
    $result = false
    let(:params) { { name: "qwerty", phone: "654987321" } }
    subject { $result }

    before do
      user.save
      $result = user.update_profile(params)
    end

    it { is_expected.to be_truthy }

    it "persists changes" do
      expect(user.name).to eq("Qwerty")
      expect(user.phone).to eq("654987321")
    end

    context "when params are invalid" do
      let(:params) { { name: "", phone: "qwerty" } }

      it { is_expected.to be_falsey }
    end

    describe "name" do
      let(:params) { { name: "  qwerty   asdfg    " } }
      subject { user.name }

      context "squishes name" do
        it { is_expected.to eq("Qwerty Asdfg") }
      end

      context "Titleizes name" do
        let(:params) { { name: "foo bar" } }
        it { is_expected.to eq("Foo Bar") }
      end
    end
  end

  describe "#update_password" do
    $result = false
    let(:params) do
      { current_password: "password",
        password: "qwerty",
        password_confirmation: "qwerty" }
    end
    subject do
      user.save
      user.update_password(params)
    end

    it { is_expected.to be_truthy }

    context "when params are invalid" do
      let(:params) do
        { current_password: "",
          password: "qwe",
          password_confirmation: "qwerty" }
      end

      it { is_expected.to be_falsey }
    end
  end

  describe "updates" do
    before do
      user.save
    end

    context "update_profile" do
      describe "name" do
        context "not present" do
          let(:name) { "" }

          it { is_expected.to_not be_valid(:update_profile) }
        end

        context "is too long" do
          let(:name) { "F" * 121 }

          it { is_expected.to_not be_valid(:update_profile) }
        end
      end

      describe "phone" do
        context "not present" do
          let(:phone) { "" }

          it { is_expected.to be_valid(:update_profile) }
        end

        context "wrong format" do
          let(:phone) { "!@$%^&*()" }

          it { is_expected.not_to be_valid(:update_profile) }
        end

        context "is too long" do
          let(:phone) { "1" * 25 }

          it { is_expected.not_to be_valid(:update_profile) }
        end
      end
    end

    context "update_password" do
      describe "password" do
        context "not present" do
          let(:password) { "" }

          it { is_expected.to_not be_valid(:update_password) }
        end
      end

      describe "password_confirmation" do
        context "not present" do
          let(:password_confirmation) { "" }

          it { is_expected.to_not be_valid(:update_password) }
        end

        context "not match with password" do
          let(:password_confirmation) { "foobar" }

          it { is_expected.to_not be_valid(:update_password) }
        end
      end
    end

    context "update_email" do
      describe "email" do
        context "not present" do
          let(:email) { "" }

          it { is_expected.to_not be_valid(:update_email) }
        end

        context "wrong format" do
          let(:email) { "foobar.com" }

          it { is_expected.to_not be_valid(:update_email) }
        end

        context "taken" do
          it "should not be valid" do
            user = build(:user, email: "foo@bar.com")
            user.save
            expect(user).to be_invalid
          end
        end
      end
    end
  end
end
