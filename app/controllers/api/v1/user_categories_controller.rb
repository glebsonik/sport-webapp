module Api
  module V1
    class UserCategoriesController < ApplicationController
      def index
        @presenter = UserCategoriesPresenter.new(params[:language_key], params[:category])

        @articles = @presenter.articles(params).load

        render json: {
          articles: render_to_string(partial: 'partials/user_article', collection: @articles),
          count: @articles.length,
          last: @articles.length < @presenter.per_page
        }
      end
    end
  end
end
