class ArticlesController < AdminController
  def new
    @translated_category = CategoryTranslation.translation_for(params[:key_name], current_language_key)

    @translated_conferences = ConferenceTranslation.left_joins(:language, conference: :category)
                                                   .where(categories: { key_name: params[:key_name] })
                                                   .where(languages:  { key: current_language_key })
  end

  def create
    article_hash = ArticleParamsBuilder.new(params, current_user.id).build
    @article = Article.new(article_hash)

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

end
