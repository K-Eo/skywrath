ENV['RAILS_ENV'] = 'test'
require './config/environment'
require 'rspec/expectations'

Spinach.hooks.before_run do
  include FactoryBot::Syntax::Methods
end

# Spinach.config.save_and_open_page_on_failure = true
