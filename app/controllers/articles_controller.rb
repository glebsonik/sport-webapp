class ArticlesController < AdminController
  def new
    category = Category.find_by(key_name: params[:key_name])
    @translated_category = category.translation_for(current_language.id)

    @conferences = category.conferences

    @translated_conferences = category.conferences.map do |conference|
      conference.translation_for(current_language.id)
    end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to admin_categories_path(params[:category_key]), notice: "Article saved successfully!"
    else
      redirect_to admin_categories_path(params[:category_key]), alert: "Couldn't save article. Something went wrong!"
    end
  end

  def update
    #WIP
  end

  private

  def article_params
    {author_id: User.find_by(user_name: params[:author_user_name]).id,
     category_id: Category.find_by(key_name: params[:category_key]).id,
     conference_id: Conference.find_by(key_name: params[:conference_key]).id,
     team_id: params[:team_id],
     location_id: Location.find_by(key_name: params[:location_key])&.id,
     article_translations_attributes: [article_translation_params]}
  end

  def article_translation_params
    {language_id: current_language.id,
     picture: params[:picture],
     alt_image: params[:alt_image],
     caption: params[:caption],
     content: params[:content],
     show_comments: params[:show_comments] == '1' ? true : false,
     status: :unpublished}
  end

end
