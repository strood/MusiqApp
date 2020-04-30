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

    # Cant get pass and email validaiton to work before sending to db,
    # try to get it working later if i feel. 

    # if User.email_taken?(@user.email)
    #   flash.now[:errors] = ["Email taken, sign in, or try another."]
    #   render :new
    # elsif !User.pass_valid?(params[:user][:password])
    #   flash.now[:errors] = ["Password invalid, please try another."]
    #   render :new
    # end

    if @user.save!
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Credentials, pelase try again!"]
      redirect_to new_user_url
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
