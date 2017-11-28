module API
  module V1
    class Alerts < Grape::API
      include API::V1::Defaults

      resource :alerts do
        desc "Returns the list of posts that belong to a user"
        get do
          authenticate!

          alerts = Alert.newest

          case params[:state].to_s
          when "opened"
            alerts = alerts.with_state(:opened)
          when "closed"
            alerts = alerts.with_state(:closed)
          end

          alerts = alerts
                    .includes(:author, :assignee)
                    .page(params[:page])

          present paginate(alerts), with: API::V1::Entities::Alert
        end

        desc "Creates new alerts"
        post do
          authenticate!

          alert = ::Alerts::CreateService.new(current_user)

          if alert.execute
            present alert.entity, with: API::V1::Entities::Alert
          else
            api_error!({ error: "422 Unprocessable entity" }, 422)
          end
        end

        desc "Assigns current user to alert"
        post "/:alert_id/assign" do
          authenticate!

          alert = Alert.find(params[:alert_id])

          alert.assignee = current_user

          if alert.save
            present alert, with: API::V1::Entities::Alert
          else
            api_error!({ error: "422 Unprocessable entity" }, 422)
          end
        end

        desc "Close an alert"
        patch "/:alert_id/close" do
          authenticate!

          alert = Alert.find(params[:alert_id])

          alert.close

          present alert, with: API::V1::Entities::Alert
        end
      end
    end
  end
end
