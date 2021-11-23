require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do

  describe "GET /teams" do
    let(:language)    { create(:language) }
    let(:category)    { create(:category) }
    let(:conference)  { create(:conference, category: category) }
    let(:team)        { create(:team, conference: conference) }

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
      let(:additional_conference) { create(:conference, category: category) }
      let(:expected_teams) do
        [team, *additional_teams].map{|team| team.as_json(except: [:created_at, :updated_at])}
      end
      let(:additional_teams) { create_list(:team, 2, :with_category) }

      before do
        additional_conference
        expected_teams
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