class UsersController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  before_action :require_correct_user!, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render plain @user.email
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Credentials"]
      redirect_to new_user_url
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
