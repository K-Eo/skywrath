module API
  module V1
    module Entities
      class BasicUser < Grape::Entity
        include API::Helpers::Common

        expose :id, :name
        expose :avatar do |instance|
          avatar(instance.email)
        end
        expose :lat
        expose :lng
      end

      class AccessToken < Grape::Entity
        expose :access_token
      end

      class Alert < Grape::Entity
        expose :id
        expose :created_at
        expose :state
        expose :assignee, using: BasicUser
        expose :author, using: BasicUser
      end
    end
  end
end
