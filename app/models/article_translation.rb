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
  acts_as_commontable dependent: :destroy

  def raw_content_preview
    ApplicationController.helpers.rich_text_as_string(content[0..250])
  end
end
