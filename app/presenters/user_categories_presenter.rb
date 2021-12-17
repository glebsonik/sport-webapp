class UserCategoriesPresenter
  ARTICLES_PER_PAGE = 10
  attr_reader :per_page

  def initialize(language_key, category_key, per_page = ARTICLES_PER_PAGE)
    @language_key = language_key
    @category_key = category_key
    @per_page = per_page

    raise ArgumentError.new "Argument error" unless @language_key && @category_key && @per_page
  end

  def articles(params)
    @articles ||= ArticleTranslation.left_joins(:language,
                                                { article: [:category, :conference, :team] })
                                    .where(query_from_params(params))
                                    .order(created_at: :desc)
                                    .limit(@per_page).offset(params[:page].to_i * @per_page)
  end

  private

  def query_from_params(params)
    query = {
      languages: { key: @language_key },
      categories: { key: @category_key },
      status: ArticleTranslation::PUBLISHED
    }

    query[:conferences] = {key: params[:conference]} if params[:conference].present?
    query[:teams] = {id: params[:team]} if params[:team].present?

    query
  end
end