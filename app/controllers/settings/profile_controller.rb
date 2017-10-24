class Settings::ProfileController < Settings::ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_profile(user_params)
      flash[:success] = "Perfil actualizado"
      redirect_to settings_profile_path
    else
      render "show"
    end
  end

private

  def user_params
    params.require("user")
          .permit(:name, :phone)
  end
end
