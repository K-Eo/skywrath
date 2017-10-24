class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def route_not_found
    render_404
  end

  def after_sign_in_path_for(resource_or_scope)
    dashboard_path
  end

private

  def render_404
    respond_to do |format|
      format.html do
        render "errors/404", status: "404", layout: "errors"
      end
      format.any { head :not_found }
    end
  end
end
