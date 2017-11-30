class NewAlertJob < ApplicationJob
  queue_as :default

  def perform(alert_id, user_id)
    NotificationService.new.new_alert(alert_id, user_id)
  end
end
