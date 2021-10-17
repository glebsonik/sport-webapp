class AdminCategoriesController < AdminController

  def show
    @category = Category.find_by(key_name: params[:key_name])

    return redirect_to(admin_home_url, alert: 'incorrect category') unless @category

    @translated_category = @category.translation_for(current_language.id)

    prepare_translated_articles
  end

  private
  def prepare_translated_articles
    @translated_articles = Article.where(category_id: @category.id).map do |article|
      article.translation_for(current_language.id)
    end
  end

end
