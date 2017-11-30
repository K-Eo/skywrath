class NotificationService
  def new_alert(alert_id, user_id)
    alert = Alert.find(alert_id)
    data = render_alert(alert)

    Pusher.trigger "alerts",
                   "new",
                   html: data,
                   id: alert.id,
                   origin: user_id
  end

  def new_assignee(alert_id, user_id)
    alert = Alert.find(alert_id)
    data = render_alert(alert)

    Pusher.trigger "alerts",
                   "assignee",
                   html: data,
                   id: alert.id,
                   origin: user_id
  end

private

  def render_alert(alert)
    ApplicationController.render(
      partial: "alerts/alert",
      locals: { alert: alert }
    )
  end
end
