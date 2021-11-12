class AdminCategoriesController < AdminController
  def show
    #TODO: Implement Presenter
    # https://github.com/skrix/lunch_app/blob/eb9da0f73c22dcbe18234fead4621a01eb64cf3e/app/facades/menus/index_facade.rb
    # https://github.com/skrix/lunch_app/blob/eb9da0f73c22dcbe18234fead4621a01eb64cf3e/app/controllers/menus_controller.rb
    #
    @translated_category = CategoryTranslation.translation_for(params[:key], current_language_key)

    return redirect_to(admin_home_url, alert: 'incorrect category') unless @translated_category

    @translated_articles = prepare_translated_articles(@translated_category.category_id)
  end

  private

  def prepare_translated_articles(category_id)
    ArticleTranslation.left_joins(:language, :article)
                      .where(languages: { key: current_language_key }, articles: { category_id: category_id })
                      .left_joins(:article, { article: :team }, article: {category: :category_translations})
                      .select('article_translations.*, category_translations.name as category_name, teams.name as team_name')

  end
end