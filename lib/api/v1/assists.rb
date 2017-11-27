module API
  module V1
    class Assists < Grape::API
      include API::V1::Defaults

      resource :assists do
        desc "Assists an alert"

        post ":alert_id/assist" do
          authenticate!

          alert = Alert.find(params[:alert_id])

          alert.assisted_by = current_user
          alert.assist

          present alert, with: API::V1::Entities::Alert
          # api_error!({ error: "406 Not Acceptable" }, 406)
        end

        post ":alert_id/close" do
          authenticate!

          alert = Alert.find(params[:alert_id])

          alert.closed_by = current_user
          alert.close

          present alert, with: API::V1::Entities::Alert
        end
      end
    end
  end
end
