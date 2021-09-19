class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: "User was successfully created!"
    else
      render :new, alert: "Incorrect values"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_name, :password, :password_confirmation)
  end
end