module API
  module V1
    class Alerts < Grape::API
      include API::V1::Defaults

      resource :alerts do
        desc "Returns the list of posts that belong to a user"
        get do
          authenticate!

          alerts = Alert.newest
                        .includes(:author, :assignee)
                        .page(params[:page])
          present paginate(alerts), with: API::V1::Entities::Alert
        end

        desc "Creates new alerts"
        post do
          authenticate!

          alert = Alert.new(author: current_user)

          if alert.save
            NewAlertJob.perform_later(alert.id)
            present alert, with: API::V1::Entities::Alert
          else
            api_error!({ error: "422 Unprocessable entity" }, 422)
          end
        end

        desc "Assign current user as assignee"
        post ":id/assign" do
          authenticate!

          alert = Alert.find(params[:id])
          alert.with_lock do
            if alert.assignee.nil?
              alert.assignee = current_user
              alert.save!
            end
          end

          NewAssigneeJob.perform_later(alert.id)
          present alert, with: API::V1::Entities::Alert
        end
      end
    end
  end
end
