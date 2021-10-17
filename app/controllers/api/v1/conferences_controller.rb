module Api
  module V1
    class ConferencesController < Api::V1::ApiApplicationController
      # def conferences
      # end

      def translated
        category_id = params[:category_id]
        return render json: {error: "please add category_id param"}, status: 404 unless category_id

        @translated_conferences = []
        Conference.where(category_id: category_id).find_each do |conference|
          @translated_conferences << conference.conference_translations.find_by(language_id: used_language.id)
        end

        render json: @translated_conferences, except: [:created_at, :updated_at]
      end
      #
      # def by_id
      # end
      #
      # def translated_by_id
      # end
    end
  end
end
