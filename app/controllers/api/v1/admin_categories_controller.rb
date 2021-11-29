module Api
  module V1
    class AdminCategoriesController < ApiApplicationController
      def index
        @presenter = AdminCategoriesPresenter.new(params[:language_key], params[:key])

        filtered_articles = @presenter.filtered_articles(params).load
        render json: {
          articles: render_to_string(partial: "api/v1/admin_categories/article", collection: filtered_articles),
          count: filtered_articles.length,
          last: filtered_articles.length < AdminCategoriesPresenter::ARTICLES_PER_PAGE
        }
      end
    end
  end
end
