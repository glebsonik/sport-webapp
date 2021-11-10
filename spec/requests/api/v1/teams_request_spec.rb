require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do

  describe "GET /teams" do
    let(:language) do
      Language.create(key: 'en', display_name: 'English')
    end
    let(:category) do
      Category.create(key: 'nba')
    end
    let(:conference) do
      Conference.create(key: 'nba_conf_1', category: category)
    end
    let(:team) do
      Team.create(name: 'NBA Conf Team 1', conference: conference)
    end

    before do
      language
      category
      conference
      team
    end

    context 'when given conference_id param' do
      subject(:result) { JSON.parse(response.body).first }
      let(:expected) { team.as_json(except: [:created_at, :updated_at]) }

      before do
        get "/api/v1/teams?conference_id=#{conference.id}"
      end

      it 'returns http success status when given conference_id param' do
        expect(response).to have_http_status(:success)
      end

      it 'returns teams correct JSON array' do
        expect(response).to match_json_schema('teams')
      end

      it 'has corresponding team in JSON array' do
        expect(result).to eq(expected)
      end
    end

    context 'when no conference_id given' do
      subject(:no_param_result) {JSON.parse(response.body)}
      let(:additional_conference) do
        Conference.create(key: 'other_key', category: category)
      end
      let(:additional_team) do
        Team.create(name: 'Other Team', conference: additional_conference)
      end
      let(:expected_teams) do
        [team, additional_team].map{|team| team.as_json(except: [:created_at, :updated_at])}
      end

      before do
        additional_conference
        additional_team
        get '/api/v1/teams'
      end

      it 'returns all Teams' do
        expected_teams.each do |team|
          expect(no_param_result).to include(team)
        end
      end
    end

    context 'when invalid conference_id given' do
      subject(:result) { JSON.parse(response.body) }

      let(:invalid_conference_id) { "invalid_id" }

      before do
        get "/api/v1/teams?conference_id=#{invalid_conference_id}"
      end

      it 'returns empty JSON' do
        expect(result).to eq([])
      end
    end
  end
end