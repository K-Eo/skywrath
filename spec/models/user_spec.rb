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

  describe "updates" do
    subject do
      user.save
      user
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

          it { is_expected.to_not be_valid }
        end

        context "wrong format" do
          let(:email) { "foobar.com" }

          it { is_expected.to_not be_valid }
        end

        context "taken" do
          before { create(:user, email: "foo@bar.com") }

          it { is_expected.to_not be_valid }
        end
      end
    end
  end
end
