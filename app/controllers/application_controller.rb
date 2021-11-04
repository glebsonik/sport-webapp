class ApplicationController < ActionController::Base

  helper_method :current_user, :current_language
  before_action :validate_or_set_language
  around_action :switch_locale

  include LanguageControllable

  private


  def authorize!
    unless current_user.present? && current_user.active?
      redirect_to sign_in_url, alert: "You must be logged in for this operation"
      false
    end
    true
  end

  def current_user
    return unless session[:user_token].present?

    user_id = Encryptor.new.decrypt(session[:user_token])
    @current_user ||= User.find(user_id)
  end

end