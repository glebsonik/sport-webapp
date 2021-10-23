module LanguageControllable
  extend ActiveSupport::Concern

  private

  def current_language_key
    cookies[:language] || DEFAULT_LANGUAGE
  end

  def current_language
    @current_language ||= Language.find_by(key: current_language_key)
  end

end