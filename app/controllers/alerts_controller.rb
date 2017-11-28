class AlertsController < ApplicationController
  before_action :authenticate_user!
  layout "default"

  def index
  end
end
