class ConferenceTranslation < ApplicationRecord
  belongs_to :conference
  belongs_to :language

  validates :name, presence: true

  delegate :key_name, to: :conference

end
