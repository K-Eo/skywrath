class AlertsController < ApplicationController
  before_action :authenticate_user!
  layout "default"

  def index
    @alerts = Alert.newest.includes(:author).page(params[:page])
  end

  def create
    @alert = Alert.new(author: current_user)

    respond_to do |format|
      format.js
    end
  end
end
