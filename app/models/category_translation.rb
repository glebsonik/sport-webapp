class CategoryTranslation < ApplicationRecord
  CACHE_KEY = "category_translation_cache"
  belongs_to :category
  belongs_to :language

  validates :name, presence: true

  include CacheRefreshable

  def self.translation_for(category_key, language_key)
    left_joins(:language)
      .find_by(languages: { key: language_key },
               key: category_key)
  end

  private

  def cache_key
    CACHE_KEY
  end

end
