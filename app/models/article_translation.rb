class ArticleTranslation < ApplicationRecord
  belongs_to :article
  belongs_to :language

  mount_uploader :picture, ArticlePictureUploader
end
