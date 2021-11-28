class AdminCategoriesPresenter
  ARTICLES_PER_PAGE = 10
  attr_reader :category_translation

  def initialize(language_key, category_key, per_page = ARTICLES_PER_PAGE)
    @language_key = language_key
    @category_translation = CategoryTranslation.translation_for(category_key, @language_key)
    @per_page = per_page

    unless @category_translation
      raise ArgumentError.new "No category translation found by #{category_key} and #{@language_key}"
    end
  end

  def articles
    @articles ||= ArticleTranslation.left_joins(:language, :article)
                                    .where(*article_translation_query)
                                    .left_joins(article_join_params)
                                    .select(selected_fields)
                                    .order(created_at: :desc)

  end

  def sorted_articles(params)
    final_filter_query = {}
    final_filter_query[:conferences] = {id: params[:conference]} if params[:conference].present?
    final_filter_query[:teams] = {id: params[:team]} if params[:team].present?
    final_filter_query[:status] = params[:published] if params[:published].present?

    page = params[:page] ? params[:page].to_i : 0

    final_filter_query.empty? ? with_offset(articles, page) : with_offset(articles.where(final_filter_query), page)
  end

  def conferences_hash
    articles.map{|article| [article.conference_name, article.conference_id]}.uniq.to_h
  end

  def teams_hash(conference_id = nil)
    if conference_id && conference_id.to_s.strip != ''
      articles_array = articles.to_a.select { |article| article.conference_id == conference_id.to_i }
    else
      articles_array = articles.to_a
    end
    articles_array.map{|article| [article.team_name, article.team_id]}.uniq.to_h
  end

  private

  def with_offset(collection, page)
    collection.limit(@per_page).offset(page * @per_page)
  end

  def article_translation_query
    [languages: { key: @language_key }, articles: { category_id: @category_translation.category_id }]
  end

  def article_join_params
    [:article, { article: :team }, article: {category: :category_translations, conference: :conference_translations}]
  end

  def selected_fields
    'article_translations.*, articles.id as article_id'\
    ', category_translations.name as category_name'\
    ', teams.id as team_id, teams.name as team_name'\
    ', conferences.id as conference_id, conference_translations.name as conference_name'
  end

end