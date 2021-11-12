class LocationTranslation < ApplicationRecord
  belongs_to :conference
  belongs_to :language
  belongs_to :location
end
