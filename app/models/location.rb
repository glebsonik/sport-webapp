class Location < ApplicationRecord
  has_many :location_translation

  validates :key, presence: true, uniqueness: true
end
