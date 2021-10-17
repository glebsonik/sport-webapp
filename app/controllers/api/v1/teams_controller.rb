module Api
  module V1
    class TeamsController < ApplicationController
      def teams
        conference_id = params[:conference_id] || Conference.find_by(key_name: params[:conference_key])
        return render json: {error: "please specify conference_id"} unless conference_id

        @teams = Team.where(conference_id: conference_id)
        render json: @teams, except: [:created_at, :updated_at]
      end
    end
  end
end