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
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    else

      # starts a session for user if found and pass matches above
      login_user!(user)
      # temp redirect for now
      redirect_to user_url(user)
    end

  end

  def destroy

    logout_user!
    redirect_to new_session_url
  end
end
