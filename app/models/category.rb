class Category < ApplicationRecord
  has_many :category_translations
  has_many :conferences

  validates :key_name, presence: true, uniqueness: true

  def translation_for(language_id)
    self.category_translations.find_by(language_id: language_id)
  end

end
