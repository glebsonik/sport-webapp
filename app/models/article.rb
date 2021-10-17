class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :category
  belongs_to :conference
  belongs_to :team, optional: true
  belongs_to :location, optional: true

  has_many :article_translations
  accepts_nested_attributes_for :article_translations

  def translation_for(language_id)
    self.article_translations.find_by(language_id: language_id)
  end

end