class CategoryTranslation < ApplicationRecord
  belongs_to :category
  belongs_to :language

  delegate :key_name, to: :category

  validates :name, presence: true
end
