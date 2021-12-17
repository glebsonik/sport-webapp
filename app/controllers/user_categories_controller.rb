class UserCategoriesController < UserApplicationController
  def show
    presenter = UserCategoriesPresenter.new(current_language_key, params[:category])
    @first_articles = presenter.articles(params).load
    @last_page = @first_articles.length < presenter.per_page

    @breadcrumbs_presenter = UserCategoriesBreadcrumbsPresenter.new(@navigation, params)
  end

  private

  def prepare_breadcrumbs_params
    @navigation[:categories].find{|category| category[:key] == params[:category]}
  end
end
