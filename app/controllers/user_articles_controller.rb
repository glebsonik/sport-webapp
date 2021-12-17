class UserArticlesController < UserApplicationController
  def show
    @article = ArticleTranslation.left_joins(:language).find_by(article_id: params[:id],
                                                                languages: {key: current_language_key})

    commontator_thread_show(@article)
  end
end
