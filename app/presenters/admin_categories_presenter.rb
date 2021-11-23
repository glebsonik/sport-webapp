class AdminCategoriesPresenter
  attr_reader :category_translation

  def initialize(language_key, category_key)
    @language_key = language_key
    @category_translation = CategoryTranslation.translation_for(category_key, @language_key)

    unless @category_translation
      raise ArgumentError.new "No category translation found by #{category_key} and #{@language_key}"
    end
  end

  def articles
    @articles ||= ArticleTranslation.left_joins(:language, :article)
                        .where(*where_params)
                        .left_joins(*article_join_params)
                        .select(select_string)
  end

  private

  def where_params
    [languages: { key: @language_key }, articles: { category_id: @category_translation.category_id }]
  end

  def article_join_params
    [:article, { article: :team }, article: {category: :category_translations}]
  end

  def select_string
    'article_translations.*, category_translations.name as category_name, teams.name as team_name, articles.id as article_id'
  end

end