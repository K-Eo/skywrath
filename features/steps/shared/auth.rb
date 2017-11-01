module Shared
  module Auth
    include Spinach::DSL

    step 'User "Mia Volkova" exists' do
      @user = create(:user, name: "Mia Volkova")
    end

    step 'I sign in as user' do
      @user = create(:user, name: nil, phone: nil) if @user.nil?
      sign_as(@user)
    end

  private

    def sign_as(user)
      visit new_user_session_path

      within "#new_user" do
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: "password"

        click_on "Iniciar sesión"
      end
    end
  end
end
