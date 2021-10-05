class ArticleTranslation < ApplicationRecord
  belongs_to :article
  belongs_to :language
  has_rich_text :content
end
