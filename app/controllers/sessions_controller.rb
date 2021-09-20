class SessionsController < ApplicationController
  def new
  end

  def create
    params.permit(:user_name, :password)
    user = User.find_by(user_name: params[:user_name])
    p user && user.authenticate(params[:password])
    if user && user.authenticate(params[:password])
      reset_session
      session[:user_token] = Encryptor.new.encrypt_data(user.id)
      redirect_to root_url, notice: "User was successfully created!"
    else
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def destroy
    session[:user_token] = nil
    redirect_to root_url, notice: "Logged out"
  end
end
