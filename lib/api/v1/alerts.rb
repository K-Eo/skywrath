module API
  module V1
    class Alerts < Grape::API
      include API::V1::Defaults

      resource :alerts do
        desc "Returns the list of posts that belong to a user"
        get do
          authenticate!

          alerts = current_user.alerts.newest.includes(:author).page
          present paginate(alerts), with: API::V1::Entities::Alert
        end

        desc "Creates new alerts"
        post do
          authenticate!

          alert = Alert.new(author: current_user)

          if alert.save
            present alert, with: API::V1::Entities::Alert
          else
            api_error!({ error: "422 Unprocessable entity" }, 422)
          end
        end
      end
    end
  end
end
