class NotificationService
  def new_alert(alert)
    alert = Alert.find(alert)
    users = User.all
    users.each do |user|
      begin
        Pusher.trigger("alerts", "new", data: alert)
      rescue Pusher::Error => e
        puts "Can't send alert notification: #{e.message}"
      end
    end
  end
end
