class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout "default"

  def show
  end
end
