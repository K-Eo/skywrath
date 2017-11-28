module API
  module V1
    module Entities
      class BasicUser < Grape::Entity
        include API::Helpers::Common

        expose :id, :name
        expose :avatar do |instance|
          avatar(instance.email)
        end
      end

      class AccessToken < Grape::Entity
        expose :access_token
      end

      class Alert < Grape::Entity
        expose :author, using: BasicUser
        expose :closed_at
        expose :created_at
        expose :id
        expose :state
        expose :assignee, using: BasicUser
      end

      class PSAlert < Grape::Entity
        expose :data do
          expose :author_id, as: :author
          expose :closed_at
          expose :created_at
          expose :id
          expose :state
          expose :assignee_id, as: :assignee
        end
        expose :meta do
          expose :action do |instance|
            "load"
          end
          expose :type do |instance|
            "users"
          end
          expose :author_id, as: :entity
        end
      end
    end
  end
end
