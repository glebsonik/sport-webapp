class ArticleParamsBuilder
  def initialize(params, author)
    @params = params
    @author = author
  end

  def build
    article_params.merge(article_translations_attributes: [article_translation_params])
  end

  private

  attr_reader :params, :author

  def article_params
    {
      category_id:   params[:category_id],
      conference_id: params[:conference_id],
      team_id:       params[:team_id],
      location_id:   params[:location_id],
      author_id:     author.id
    }
  end

  def article_translation_params
    {
      language_id:   params[:language_id],
      picture:       params[:picture],
      alt_image:     params[:alt_image],
      headline:      params[:headline],
      caption:       params[:caption],
      content:       params[:content],
      show_comments: sanitize_bool(params[:show_comments]),
      status:        Article::UNPUBLISHED
    }
  end

  def sanitize_bool(value)
    BooleanSanitizer.sanitize(value)
  end
end
