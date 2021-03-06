class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from AccessDenied, :with => :access_denied

  def access_denied
    redirect_to "/401.html"
  end

  protected :access_denied
end
