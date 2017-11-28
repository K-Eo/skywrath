module API
  module V1
    class Channels < Grape::API
      include API::V1::Defaults

      resource :channels do
        desc "Return current user channels list for push notifications"

        get do
          authenticate!

          [
            "#{current_user.id}"
          ]
        end
      end
    end
  end
end
