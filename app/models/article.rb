class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :category
  belongs_to :conference
  belongs_to :team, optional: true
  belongs_to :location, optional: true
end