module LanguageControllable
  DEFAULT_LANGUAGE = 'en'
  LANG_EXPIRATION_TIME = 1.years

  extend ActiveSupport::Concern

  private

  def validate_or_set_language
    cookies[:language] ||= { value: DEFAULT_LANGUAGE, expires: LANG_EXPIRATION_TIME }
  end

  def current_language_key
    cookies[:language] || DEFAULT_LANGUAGE
  end

  def current_language
    @current_language ||= Language.find_by(key: current_language_key)
  end

end