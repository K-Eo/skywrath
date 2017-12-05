class AlertsController < ApplicationController
  layout "default"

  before_action :authenticate_user!
  before_action :set_alert, only: [:close, :show]

  def index
    @alerts = Alert.newest.includes(:author, :assignee).page(params[:page])
  end

  def show
  end

  def create
    @alert = Alert.new(author: current_user)

    if @alert.save
      NewAlertJob.perform_later(@alert.id)
    end

    respond_to do |format|
      format.js
    end
  end

  def close
    respond_to do |format|
      @alert.close
      format.js
      format.html { redirect_to @alert }
    end
  end

private

  def set_alert
    @alert = Alert.find(params[:id])
  end
end
