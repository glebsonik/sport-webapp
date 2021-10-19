class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_name: params[:user_name])

    if user && user.authenticate(params[:password])
      create_user_session!(user)

      redirect_by_status(user)
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
    reset_session
    session[:user_token] = Encryptor.new.encrypt(user.id)
  end

  def delete_user_session!
    reset_session
    session[:user_token] = nil
  end

  def redirect_by_status(user)
    if user.status == 'active'
      redirect_to root_url, notice: "Successfully signed in!"
    elsif user.status == 'pending_email'
      redirect_to preconfirmation_url
    elsif user.status == 'blocked'
      redirect_to root_url
    else
      render template: "shared/500.html", status: 501
    end
  end
end
