class Conference < ApplicationRecord
  belongs_to :category
  has_many :conference_translations
  has_many :teams

  validates :key_name, presence: true, uniqueness: true

  def translation_for(language_id)
    self.conference_translations.find_by(language_id: language_id)
  end

end
