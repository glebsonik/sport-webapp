module Api
  module V1
    class AdminCategoriesController < ApiApplicationController
      def index
        @presenter = AdminCategoriesPresenter.new(params[:language_key], params[:key])

        sorted_articles = @presenter.sorted_articles(params).load
        render json: {
          articles: render_to_string(partial: "api/v1/admin_categories/article", collection: sorted_articles),
          count: sorted_articles.length,
          last: sorted_articles.length < AdminCategoriesPresenter::ARTICLES_PER_PAGE
        }
      end
    end
  end
end
