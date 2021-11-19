class UpdateArticleParamsBuilder

  def initialize(params)
    @params = params
  end

  def build
    article_params.merge(article_translations_attributes: [article_translation_params])
  end

  private

  attr_reader :params

  def article_params
    HashNilsSanitizer.sanitize_nils(
      {
        category_id:   params[:category_id],
        conference_id: params[:conference_id],
        team_id:       params[:team_id],
        location_id:   params[:location_id],
      })
  end

  def article_translation_params
    HashNilsSanitizer.sanitize_nils(
      {
        language_id:   params[:language_id],
        picture:       params[:picture],
        alt_image:     params[:alt_image],
        headline:      params[:headline],
        caption:       params[:caption],
        content:       params[:content],
        show_comments: params[:show_comments] ? sanitize_bool(params[:show_comments]) : nil,
        status:        params[:status]
    })
  end
end