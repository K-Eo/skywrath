class NotificationService
  def new_alert(alert_id)
    alert = Alert.find(alert_id)
    Pusher.trigger "alerts", "new", API::V1::Entities::Alert.represent(alert)
  end

  def new_assignee(alert_id)
    alert = Alert.find(alert_id)
    Pusher.trigger "alerts", "assignee", API::V1::Entities::Alert.represent(alert)
  end
end
