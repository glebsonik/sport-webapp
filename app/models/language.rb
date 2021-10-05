class Language < ApplicationRecord
  validates :key, :display_name, presence: true, uniqueness: true
end
