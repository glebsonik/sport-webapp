class CategoryTranslation < ApplicationRecord
  belongs_to :category
  belongs_to :language

  validates :name, presence: true

  def self.translation_for(category_key, language_key)
    left_joins(:category, :language)
      .where(categories: { key: category_key })
      .find_by(languages: { key: language_key })
  end

end
