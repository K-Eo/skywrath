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
          when "active"
            alerts = alerts.with_states(:opened, :assisting)
          when "opened"
            alerts = alerts.with_state(:opened)
          when "assisting"
            alerts = alerts.with_state(:assisting)
          when "closed"
            alerts = alerts.with_state(:closed)
          end

          alerts = alerts
                    .includes(:author, :assisted_by, :closed_by)
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
      end
    end
  end
end
