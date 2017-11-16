class NewAlertJob < ApplicationJob
  queue_as :critical

  def perform(alert_id)
    NotificationService.new.new_alert(alert_id)
  end
end
