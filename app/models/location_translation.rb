class LocationTranslation < ApplicationRecord
  belongs_to :conference
  belongs_to :language
end
