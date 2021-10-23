class AdminCategoriesController < AdminController

  def show
    @translated_category = CategoryTranslation.translation_for(params[:key_name], current_language_key)

    return redirect_to(admin_home_url, alert: 'incorrect category') unless @translated_category
    prepare_translated_articles
  end

  private

  def prepare_translated_articles
    @translated_articles = ArticleTranslation.left_joins(:language, :article)
                                             .where(languages: { key: current_language_key },
                                                    articles: { category_id: @translated_category.category_id })
  end

end
