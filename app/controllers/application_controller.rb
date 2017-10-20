class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
