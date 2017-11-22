class NotificationService
  def new_alert(alert)
    alert = Alert.find(alert)
    json_alert = API::V1::Entities::PSAlert.represent(alert)
    users = User.all
    users.each do |user|
      begin
        Pusher.trigger("#{user.id}", "alerts/ADD", json_alert)
      rescue Pusher::Error => e
        puts "Can't send alert notification: #{e.message}"
      end
    end
  end
end
