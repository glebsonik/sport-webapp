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
                        .where(*article_translation_query)
                        .left_joins(:article, { article: :team }, article: {category: :category_translations})
                        .select(selected_fields)
  end

  private

  def article_translation_query
    [languages: { key: @language_key }, articles: { category_id: @category_translation.category_id }]
  end

  def selected_fields
    'article_translations.*, category_translations.name as category_name, teams.name as team_name, articles.id as article_id'
  end

end