class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?
  helper_method :login_user!


  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: sesison[:session_token])
  end

  def logged_in?
    unless current_user.nil?
  end

  def require_no_user!
    redirect_to user_url(current_user) unless current_user.nil?
  end

  def require_correct_user!
    redirect_to user_url(current_user) if current_user.id != params[:id]
  end

  def require_user!
    redirect_to new_session_url unless current_user
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token
  end

  def logout_user!
    current_user.reset_session_token
    session[:session_token] = nil
  end

end
