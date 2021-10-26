module Api
  module V1
    class TeamsController < ApplicationController
      def teams
        return render json: {error: "please specify conference_id"}, status: 400 unless params[:conference_id]

        @teams = Team.where(conference_id: params[:conference_id])

        render json: @teams, except: [:created_at, :updated_at]
      end
    end
  end
end