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
      end
    end
  end
end
