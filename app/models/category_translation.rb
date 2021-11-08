class CategoryTranslation < ApplicationRecord
  belongs_to :category
  belongs_to :language

  validates :name, presence: true

  def self.translation_for(category_key, language_key)
    left_joins(:language)
      .find_by(languages: { key: language_key },
               key: category_key)
  end

end
