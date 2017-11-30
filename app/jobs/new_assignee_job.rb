class NewAssigneeJob < ApplicationJob
  queue_as :default

  def perform(alert_id, user_id)
    NotificationService.new.new_assignee(alert_id, user_id)
  end
end
