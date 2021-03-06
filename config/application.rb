require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Skywrath
  def self.skywrath_url
    if ENV['RAILS_ENV'] == 'production' || ENV['HEROKU_APP_NAME']
      app_name = ENV['HEROKU_APP_NAME'] || 'skywrath'
      origins = "https://#{app_name}.herokuapp.com/*"
    else
      origins = "localhost:3000"
    end

    origins
  end

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :es

    config.eager_load_paths.push(*%W[#{config.root}/lib #{config.root}/app/services])

    # Allow access from other domains
    config.middleware.insert_before Warden::Manager, Rack::Cors do
      allow do
        origins Skywrath::skywrath_url
        resource '/api/*',
          credentials: true,
          headers: :any,
          methods: :any,
          expose: ['X-Total', 'X-Total-Pages', 'X-Per-Page', 'X-Page', 'X-Next-Page', 'X-Prev-Page']
      end

      # Cross-origin requests must not have the session cookie available
      allow do
        origins '*'
        resource '/api/*',
          credentials: false,
          headers: :any,
          methods: :any,
          expose: ['X-Total', 'X-Total-Pages', 'X-Per-Page', 'X-Page', 'X-Next-Page', 'X-Prev-Page']
      end
    end
  end
end
