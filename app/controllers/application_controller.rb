class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
     User.find_by_session_token(session[:token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def log_in_user!(user)
    session[:token] = user.reset_session_token!
    redirect_to user_url(user)
  end
  
  def log_out!(user)
    user.reset_session_token!
    session[:token] = nil
    redirect_to new_session_url
  end
end
