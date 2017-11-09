module API
  module Helpers
    module Common
      def avatar(email)
        return "" unless email.present?

        hash = Digest::MD5.hexdigest(email)
        "https://www.gravatar.com/avatar/#{hash}?s=80&d=retro"
      end
    end
  end
end
