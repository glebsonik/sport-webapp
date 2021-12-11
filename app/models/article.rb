class Article < ApplicationRecord
  include ArticleStatuses

  belongs_to :author, class_name: User.name, foreign_key: :author_id
  belongs_to :category
  belongs_to :conference
  belongs_to :team, optional: true
  belongs_to :location, optional: true

  has_many :article_translations, dependent: :destroy
  accepts_nested_attributes_for :article_translations
end