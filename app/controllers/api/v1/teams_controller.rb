module Api
  module V1
    class TeamsController < ApplicationController
      def teams
        @teams = params[:conference_id] ? Team.where(conference_id: params[:conference_id]) : Team.all

        render json: @teams, except: [:created_at, :updated_at]
      end
    end
  end
end