module API
  module Helpers
    module Auth
      def authenticate!
        unauthorized! unless authenticated?
      end

      def unauthorized!
        api_error!("401 Unauthorized", 401)
      end

      def current_user
        warden.user || @user
      end

      def api_error!(message, code)
        error!({ error: message }, code)
      end

    private

      def warden
        env["warden"]
      end

      def validate_access_token
        find_access_token
        return false unless @access_token.present?

        @user = User.find_by(access_token: @access_token)

        if @user.nil?
          false
        elsif @user.is_valid_access_token?(@access_token)
          true
        else
          false
        end
      end

      def authenticated?
        # Devise auth
        return true if warden.authenticated?

        # Token auth
        validate_access_token
      end

      def find_access_token
        @access_token = request.headers["X-Access-Token"] ||
                        params[:access_token]
      end
    end
  end
end
