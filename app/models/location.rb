class Location < ApplicationRecord
  has_many :location_translation

  validates :key_name, presence: true, uniqueness: true
end
