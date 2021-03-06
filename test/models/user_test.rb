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
      @user.name = "foo"
      @user.phone = "1230006789"
    end

    test "is valid" do
      assert @user.valid?(:update_profile)
    end

    test "invalid if not name" do
      @user.name = ""
      assert @user.invalid?(:update_profile)
    end

    test "invalid if name is too long" do
      @user.name = "f" * 121
      assert @user.invalid?(:update_profile)
    end

    test "invalid if phone is too long" do
      @user.phone = "1" * 25
      assert @user.invalid?(:update_profile)
    end

    test "invalid if wrong phone format" do
      @user.phone = "!@#$%^&*()-=_+[]{};':"
      assert @user.invalid?(:update_profile)
    end

    test "valid if not phone" do
      @user.phone = ""
      assert @user.valid?(:update_profile)
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
