module API
  module V1
    class Root < Grape::API
      mount API::V1::Alerts
      mount API::V1::Channels
      mount API::V1::Sessions
    end
  end
end
