DEFAULT_LANGUAGE = 'en'
LANG_EXPIRATION_TIME = 1.years

class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :validate_or_set_language

  include LanguageControllable

  private


  def authorize!
    unless current_user.present? && current_user.active?
      redirect_to sign_in_url, alert: "You must be logged in for this operation"
    end
  end

  def current_user
    return unless session[:user_token].present?

    user_id = Encryptor.new.decrypt(session[:user_token])
    @current_user ||= User.find(user_id)
  end

  def validate_or_set_language
    cookies[:language] ||= { value: DEFAULT_LANGUAGE, expires: LANG_EXPIRATION_TIME }
  end

end