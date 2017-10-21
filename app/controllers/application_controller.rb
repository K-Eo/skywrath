class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def route_not_found
    render_404
  end

private

  def render_404
    respond_to do |format|
      format.html do
        render "layouts/404", status: "404"
      end
      format.any { head :not_found }
    end
  end
end
