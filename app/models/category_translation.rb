class CategoryTranslation < ApplicationRecord
  belongs_to :category
  belongs_to :language

  delegate :key_name, to: :category

  validates :name, presence: true

  def self.translation_for(category_key, language_key)
    left_joins(:category, :language)
      .where(categories: { key_name: category_key })
      .find_by(languages: { key: language_key })
  end

end
