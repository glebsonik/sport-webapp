module Api
  module V1
    class ApiApplicationController < ActionController::Base

      private

      def used_language
        Language.find_by(key: params[:lang_key] || DEFAULT_LANGUAGE)
      end

    end
  end
end