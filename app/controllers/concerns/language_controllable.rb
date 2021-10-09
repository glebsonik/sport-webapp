module LanguageControllable
  extend ActiveSupport::Concern

  private

  def current_language
    Language.find_by(key: cookies[:language] || DEFAULT_LANGUAGE)
  end

end