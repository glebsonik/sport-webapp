class ApplicationController < ActionController::Base
  private

  def current_user
    return nil unless session[:user_token]
    user_id = helpers.get_user_id(session[:user_token])
    @current_user ||= User.find(user_id)
  end
  helper_method :current_user

  def authorize
    redirect_to sign_in_url, alert: "You must be logged in for this operation" if current_user.nil?
  end

end
