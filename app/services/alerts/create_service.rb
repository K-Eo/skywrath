
module Alerts
  class CreateService
    def initialize(current_user)
      @current_user = current_user
    end

    def current_user
      @current_user
    end

    def execute
      @alert = Alert.new(author: current_user)

      if @alert.save
        NotificationService.new.new_alert(@alert.id)
        true
      else
        false
      end
    end

    def entity
      @alert
    end
  end
end
