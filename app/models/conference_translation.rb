class ConferenceTranslation < ApplicationRecord
  belongs_to :conference
  belongs_to :language

  validates :name, presence: true
end
