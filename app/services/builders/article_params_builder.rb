class ArticleParamsBuilder
  def initialize(params, author_id)
    @params = params
    @author_id = author_id
  end

  def build
    article = article_params
    article[:article_translations_attributes] = [article_translation_params]

    article
  end

  private
  def article_params
    @params.permit([:category_id, :conference_id, :team_id, :location_id])
           .merge(author_id: @author_id)
           .to_hash
  end

  def article_translation_params
    translation_params = @params.permit([:language_id, :picture, :alt_image, :headline, :caption, :content])
                                .to_hash

    translation_defaults(translation_params)
  end

  def translation_defaults(translation_params)
    translation_params[:show_comments] = translation_params[:show_comments] == "1" ? true : false
    translation_params[:status] = Article::UNPUBLISHED

    translation_params
  end
end