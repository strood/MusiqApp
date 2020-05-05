class UsersController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  before_action :require_user!, only: [:show]

  # COmment out untoil bands, uncomment in app cont too.
  # before_action :require_correct_user!, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create

    @user = User.new(user_params)

    if User.email_taken?(@user.email)
      flash[:errors] = ["Email taken, sign in, or try another."]
      redirect_to new_user_url

    elsif !User.pass_valid?(params[:user][:password])
      flash[:errors] = ["Invalid password, please try another - (Must be at least 6 characters)"]
      redirect_to new_user_url
    elsif @user.save!
      login_user!(@user)
      flash[:notice] = ["Welcome, #{ @user.email }"]
      redirect_to bands_url
    else
      flash[:errors] = ["Invalid Credentials, pelase try again!"]
      redirect_to new_user_url
    end


  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
