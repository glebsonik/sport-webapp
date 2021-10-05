class Location < ApplicationRecord
  has_many :location_translations

  validates :key_name, presence: true, uniqueness: true
end
