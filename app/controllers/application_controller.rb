class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl
  private
  #has_mobile_fu

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
    def authenticate_user!
        if current_user.nil?
            redirect_to login_url, :alert => "You must first log in to access this page"
        end
    end
end
