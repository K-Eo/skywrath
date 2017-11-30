class Alerts::AssigneesController < ApplicationController
  before_action :authenticate_user!

  def create
    @alert = Alert.find(params[:alert_id])

    @alert.assignee = current_user

    if @alert.save
      NewAssigneeJob.perform_later(@alert.id, current_user.id)
    end

    respond_to do |format|
      format.js
    end
  end
end
