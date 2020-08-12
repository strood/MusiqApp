class UsersController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  before_action :require_user!, only: [:show, :index]
  before_action :require_user_activated!, only: [:index, :show]
  before_action :require_user_admin!, only: [:index]

  # COmment out untoil bands, uncomment in app cont too.
  # before_action :require_correct_user!, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def admin
    @user = User.find(params[:id])
    @user.toggle(:admin)
    @user.save!
    redirect_to users_url
  end

  def activate

    @user = User.find_by(activation_token: params[:activation_token])

    if @user
      @user.toggle(:activated)
      @user.save!
      email = UserMailer.welcome_email(@user)
      email.deliver_now
      login_user!(@user)
      render :activate
    end
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create

    @user = User.new(user_params)
    @user.activation_token = User.generate_activation_token
    @user.admin = false
    # turn back to false, only true for demo
    @user.activated = true

    if User.email_taken?(@user.email)
      flash[:errors] = ["Email taken, sign in, or try another."]
      redirect_to new_user_url

    elsif !User.pass_valid?(params[:user][:password])
      flash[:errors] = ["Invalid password, please try another - (Must be at least 6 characters)"]
      redirect_to new_user_url
    elsif @user.save!
      # email = UserMailer.activation_email(@user)
      # Could change when we send this, but will learn later
      # email.deliver_now
      flash[:notice] = ["Welcome, #{ @user.email }, pelase confirm your email to log in*Temp disabled*"]
      login_user!(@user)
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
