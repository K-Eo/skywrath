class Settings::EmailController < Settings::ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_without_password(user_params)
      flash[:success] = t("devise.confirmations.send_instructions")
      redirect_to settings_email_path
    else
      render "show"
    end
  end

private

  def user_params
    params.require("user").permit(:email)
  end
end
