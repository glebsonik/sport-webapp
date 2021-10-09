class AdminCategoriesController < AdminController

  def show
    @category = Category.find_by(key_name: params[:key_name])

    return redirect_to(admin_home_url, alert: 'incorrect category') unless @category

    @translated_category = @category.category_translations.find_by(language_id: current_language.id)
  end

end
