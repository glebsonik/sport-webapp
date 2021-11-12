class Team < ApplicationRecord
  belongs_to :conference
  belongs_to :location, optional: true

  validates :name, presence: true
end
