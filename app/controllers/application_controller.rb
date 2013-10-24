class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # client = YouTubeIt::OAuth2Client.new(client_access_token: "access_token", client_refresh_token: "refresh_token", client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], dev_key: "dev_key", expires_at: "expiration time")

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :email
  end

  
end

