class Conference < ApplicationRecord
  belongs_to :category
  has_many :conference_translations
  has_many :teams

  validates :key, presence: true, uniqueness: true

end
