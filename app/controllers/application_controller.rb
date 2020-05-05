class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # skip_before_action :verify_authenticity_token

  helper_method :current_band
  helper_method :current_user
  helper_method :current_album
  helper_method :logged_in?
  helper_method :login_user!

  def current_band
    return nil unless params[:id]
    @current_band ||= Band.find(params[:id])
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def current_album
    return nil unless params[:id]
    @current_album ||= Album.find(params[:id])
  end

  def logged_in?
    true unless current_user.nil?
  end

  def require_no_user!
    redirect_to user_url(current_user) unless current_user.nil?
  end

  # def require_correct_user!
  #   # Will change this to redirect ot bands page once created, broken atm.
  #   redirect_to user_url(current_user) unless current_user.id == params[:id]
  # end

  def require_user!
    redirect_to new_session_url unless current_user
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

end
