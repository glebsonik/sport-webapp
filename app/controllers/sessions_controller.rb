class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_name: params[:user_name])

    if user && user.authenticate(params[:password])
      create_user_session!(user)
      redirect_to root_url, notice: "User was successfully created!"
    else
      redirect_to sign_in_url, alert: "Incorrect email or password, try again."
    end
  end

  def destroy
    delete_user_session!
    redirect_to root_url, notice: "Logged out"
  end

  private

  def create_user_session!(user)
    session[:user_token] = Encryptor.new.encrypt(user.id)
  end

  def delete_user_session!
    session[:user_token] = nil
  end
end
