class Team < ApplicationRecord
  belongs_to :conference
  belongs_to :location
end
