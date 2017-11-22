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
        expose :id
        expose :created_at
        expose :author, using: BasicUser
      end

      class PSAlert < Grape::Entity
        expose :data do
          expose :id
          expose :created_at
          expose :author_id, as: :author
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
