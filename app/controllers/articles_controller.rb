class ArticlesController < AdminController
  def new
    category = Category.find_by(key_name: params[:key_name])
    @translated_category = category.category_translations.find_by(language_id: current_language.id)
  end

  def create
  end
end
