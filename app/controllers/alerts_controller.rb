class AlertsController < ApplicationController
  before_action :authenticate_user!
  layout "default"

  def index
    @alerts = Alert.newest.includes(:author, :assignee).page(params[:page])
  end

  def create
    @alert = Alert.new(author: current_user)
    @alert.save
    respond_to do |format|
      format.js
    end
  end

  def close
    @alert = Alert.find(params[:id])

    @alert.close

    respond_to do |format|
      format.js
    end
  end
end
