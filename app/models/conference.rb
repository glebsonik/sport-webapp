class Conference < ApplicationRecord
  belongs_to :category
  has_many :conference_translations
end
