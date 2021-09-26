class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.status = 'pending_email'
    @user.role = 'member'

    if @user.save
      send_confirmation_email(@user)

      redirect_to root_url, notice: "User was successfully created! Please check your email and confirm account"
    else
      render :new
    end
  end

  private

  def send_confirmation_email(user)
    UserMailer.with(user: user).confirmation_email.deliver_later
  end

  def user_params
    params.require(:user).permit(:email, :user_name, :password, :password_confirmation)
  end
end
