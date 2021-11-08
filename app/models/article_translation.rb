class ArticleTranslation < ApplicationRecord
  include ArticleStatuses

  belongs_to :article
  belongs_to :language

  validates :picture, :alt_image, :caption, :headline, :content, presence: true

  enum status: {
    unpublished: UNPUBLISHED,
    published: PUBLISHED
  }

  mount_uploader :picture, ArticlePictureUploader
end
