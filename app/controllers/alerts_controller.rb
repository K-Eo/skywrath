class AlertsController < ApplicationController
  before_action :authenticate_user!
  layout "default"

  def index
    load_alerts
  end

  def create
    alert = Alert.new(author: current_user)

    if alert.save
      flash.now[:success] = "Alerta enviada."
    else
      flash.now[:error] = "La alerta no se ha podido crear. Intente nuevamente."
    end

    load_alerts
    render "index"
  end

private

  def load_alerts
    @alerts = Alert.newest.includes(:author).all
  end
end
