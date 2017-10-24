require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "foo@bar.com",
                     password: "123456",
                     password_confirmation: "123456")
  end

  class Create < UserTest
    test "valid on create" do
      assert @user.valid?
    end

    test "invalid if not email" do
      @user.email = nil
      assert @user.invalid?
    end

    test "invalid if not password" do
      @user.password = ""
      assert @user.invalid?
    end

    test "invalid if not password confirmation" do
      @user.password_confirmation = ""
      assert @user.invalid?
    end

    test "invalid if password does not match" do
      @user.password_confirmation = "abcdef"
      assert @user.invalid?
    end

    test "invalid if email already taken" do
      User.create(
        email: "foo@bar.com",
        password: "123456",
        password_confirmation: "123456"
      )
      assert @user.invalid?
    end
  end

  class UpdateProfile < UserTest
    def setup
      super
      @user.save
      @user.first_name = "foo"
      @user.last_name = "bar"
    end

    test "is valid" do
      assert @user.valid?(:update_profile)
    end

    test "invalid if not first name" do
      @user.first_name = ""
      assert @user.invalid?(:update_profile)
    end

    test "invalid if not last name" do
      @user.last_name = ""
      assert @user.invalid?(:update_profile)
    end

    test "invalid if first name is too long" do
      @user.first_name = "foo" * 51
      assert @user.invalid?(:update_profile)
    end

    test "invalid if last name is too long" do
      @user.last_name = "bar"* 51
      assert @user.invalid?(:update_profile)
    end
  end

  class UpdatePassword < UserTest
    def setup
      super
      @user.save
      @user.password = "qwerty"
      @user.password_confirmation = "qwerty"
    end

    test "is valid" do
      assert @user.valid?(:update_password)
    end

    test "invalid if not password" do
      @user.password = ""
      assert @user.invalid?(:update_password)
    end

    test "invalid if not password confirmation" do
      @user.password_confirmation = ""
      assert @user.invalid?(:update_password)
    end

    test "invalid if passwords does not match" do
      @user.password_confirmation = "123456"
      assert @user.invalid?(:update_password)
    end
  end

  class UpdateEmail < UserTest
    def setup
      super
      @user.save
      @user.email = "foo@mail.com"
    end
  end
end
