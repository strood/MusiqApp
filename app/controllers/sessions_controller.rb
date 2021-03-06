class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]

  def new
    render :new
  end


  def create

    # /verifies password in this method
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash[:errors] = [ "Invalid Credentials, please try again!" ]
      render :new
    elsif user.activated != true
      flash[:errors] = ["Must activate account before loggin in!"]
      render :new
    else
      # starts a session for user if found and pass matches above
      login_user!(user)
      # temp redirect for now
      flash[:notice] = ["Login Successful"]
      redirect_to bands_url
    end

  end

  def destroy

    logout_user!
    redirect_to new_session_url
  end
end
