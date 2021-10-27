module Api
  module V1
    class ConferencesController < Api::V1::ApiApplicationController

      # def translated
      #   category_id = params[:category_id]
      #   return render json: {error: "please add category_id param"}, status: 400 unless category_id
      #
      #   @translated_conferences = ConferenceTranslation.left_joins(:conference, :language)
      #                                                  .where(conference: {category_id: category_id},
      #                                                         language: {key: params[:lang_key] || LanguageControllable::DEFAULT_LANGUAGE})
      #
      #   render json: @translated_conferences, except: [:created_at, :updated_at]
      # end

    end
  end
end
