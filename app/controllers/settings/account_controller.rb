class Settings::AccountController < Settings::ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user

    if account_params[:password].blank?
      @user.errors.add(:password, "no puede estar en blanco")
      render "show"
    elsif @user.update_with_password(account_params)
      flash[:success] = "Contraseña actualizada"
      bypass_sign_in(@user)
      redirect_to(settings_account_path)
    else
      render "show"
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to root_url
    else
      flash.now[:warning] = "En este momento no se puede procesar la acción solicitada"
    end
  end

private

  def account_params
    params.require("user").permit(:current_password,
                                  :password,
                                  :password_confirmation)
  end
end
