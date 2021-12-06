class AdminCategoriesController < AdminController
  def show
    @presenter = AdminCategoriesPresenter.new(current_language_key, params[:key])

    redirect_to(admin_home_url, alert: 'incorrect category') unless @presenter.category_translation.present?
  end
end