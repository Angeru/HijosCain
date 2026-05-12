class ApplicationController < ActionController::Base
  before_action :authenticate

  SESSION_TIMEOUT = 15.minutes

  def authenticate
    unless session[:user_id]
      flash[:error] = "Debes estar logeado para acceder a esa sección"
      return redirect_to new_session_path
    end

    if session[:last_active_at] && Time.now.to_i - session[:last_active_at] > SESSION_TIMEOUT
      reset_session
      flash[:error] = "Tu sesión ha expirado por inactividad."
      return redirect_to new_session_path
    end

    session[:last_active_at] = Time.now.to_i
  end

  def current_user
    @current_user ||= Member.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def require_role
    unless current_user&.has_role?
      flash[:error] = "No tienes permisos para acceder a esta sección."
      redirect_to root_path
    end
  end

  def require_president_or_treasurer
    unless current_user&.president_or_treasurer?
      flash[:error] = "Solo el presidente o el tesorero pueden acceder a esta sección."
      redirect_to root_path
    end
  end
end
