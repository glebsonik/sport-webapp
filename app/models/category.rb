class Category < ApplicationRecord
  has_many :category_translations
  has_many :conferences

  validates :key_name, presence: true, uniqueness: true


end
