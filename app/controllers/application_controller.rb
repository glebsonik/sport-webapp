class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def authorize!
    redirect_to sign_in_url, alert: "You must be logged in for this operation" unless current_user.present?
  end

  def current_user
    return unless session[:user_token].present?

    user_id = Encryptor.new.decrypt(session[:user_token])
    @current_user ||= User.find(user_id)
  end
end