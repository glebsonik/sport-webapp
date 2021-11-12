class Category < ApplicationRecord
  has_many :category_translations
  has_many :conferences

  validates :key, presence: true, uniqueness: true

end
