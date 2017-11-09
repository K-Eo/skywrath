module API
  module V1
    class Sessions < Grape::API
      include API::V1::Defaults
      default_format :txt

      resource :sessions do
        desc "Authenticates user and returns access token"
        params do
          requires :email, type: String, desc: "User email"
          requires :password, type: String, desc: "User password"
        end

        post do
          user = User.find_by(email: params[:email])

          if user.nil? || !user.valid_password?(params[:password])
            api_error!("Invalid email or password", 400)
          else
            present user, with: API::V1::Entities::AccessToken
          end
        end

        desc "Destroys the access token"
        params do
          requires :access_token, type: String, desc: "User access token"
        end

        delete ":access_token" do
          unless validate_access_token
            api_error!("Invalid access token", 400)
          end

          status :ok
        end
      end
    end
  end
end
