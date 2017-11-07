class Users::ProfileController < ApplicationController
  before_action :authenticate_user!
  layout "default"
end
