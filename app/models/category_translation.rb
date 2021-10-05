class CategoryTranslation < ApplicationRecord
  belongs_to :category
  belongs_to :language

  validates :name, presence: true
end
