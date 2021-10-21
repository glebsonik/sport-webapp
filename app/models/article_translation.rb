class ArticleTranslation < ApplicationRecord
  belongs_to :article
  belongs_to :language

  validates :picture, :alt_image, :caption, :headline, :content, presence: true

  enum status: {
    unpublished: 'unpublished',
    published: 'published'
  }

  mount_uploader :picture, ArticlePictureUploader
end
