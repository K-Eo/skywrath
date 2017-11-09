module API
  module V1
    module Helpers
      include API::Helpers::Common
      include API::Helpers::Pagination
      include API::Helpers::Auth
    end
  end
end
