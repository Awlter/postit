class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :username

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def require_user
    if !logged_in?
      flash['error'] = "You need to log in."
      redirect_to root_path
    end
  end

  def require_admin
    if !current_user.admin?
      access_denied
    end
  end

  def access_denied
    flash['error'] = "You cann't do that."
    redirect_to root_path
  end
end
