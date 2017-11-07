class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout "default"

  def show
    redirect_to alerts_path
  end
end
