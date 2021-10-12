module Api
  module V1
    class CategoriesController < Api::V1::ApiApplicationController
      def categories
      end

      def by_key_name

      end

      def translated
        @categories = Category.all

        @translated_categories = []
        Category.find_each do |category|
          @translated_categories << category.category_translations.find_by(language_id: used_language.id)
        end

        render json: @translated_categories, except: [:created_at, :updated_at]
      end

      def by_id
      end

      def translated_by_key_name
      end
    end
  end
end

