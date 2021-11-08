class ApplicationController < ActionController::Base
  helper_method :current_user, :current_language
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

    Rails.cache.fetch(session[:user_token]) do
      user_id = Encryptor.new.decrypt(session[:user_token])
      User.find(user_id)
    end
  end
end