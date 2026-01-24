class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    unless session[:user_id]
      flash[:error] = "Debes estar logeado para acceder a esa sección"
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= Member.find(session[:user_id]) if session[:user_id]
    @last_seen_at = Time.now
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?
end
