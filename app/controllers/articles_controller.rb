class ArticlesController < AdminController
  def new
    @translated_category = CategoryTranslation.translation_for(params[:key_name], current_language_key)

    @translated_conferences = ConferenceTranslation.left_joins(:language, conference: :category)
                                                   .where(categories: { key_name: params[:key_name] })
                                                   .where(languages:  { key: current_language_key })
  end

  def create
    @article = Article.new(default_article_with_translation_params)

    if @article.save
      redirect_to admin_categories_path(@article.category_id),
                  notice: "Article saved successfully!"
    else
      flash.now[:alert] = "Couldn't save article. Something went wrong!"
      render :new
    end
  end

  def update
    #WIP
  end

  private

  def default_article_with_translation_params
    defaults = article_params
    defaults[:article_translations_attributes] = [article_translation_params]
    defaults
  end

  def article_params
    params
      .permit(:category_id, :conference_id, :team_id, :location_id)
      .merge(author_id: current_user.id)
      .to_hash
  end

  def article_translation_params
    article_params_keys = [:language_id, :picture, :alt_image, :headline, :caption, :content]
    translation_params = params.permit(article_params_keys).to_hash
    translation_params[:show_comments] = translation_params[:show_comments] == "1" ? true : false
    translation_params[:language_id] = current_language.id
    translation_params[:status] = :unpublished
    translation_params
  end

end
