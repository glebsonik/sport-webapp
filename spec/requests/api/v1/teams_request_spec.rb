require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do

  describe "GET /teams" do
    let(:language_key) { 'en' }
    let(:language) {Language.find_by(key: language_key)}
    let(:conference_key) { 'nba_conf_1' }
    let(:conference_id) {Conference.find_by(key: conference_key).id}
    let(:team_name) { "NBA Conf Team 1" }

    before do
      Language.create!(key: language_key, display_name: "English")
      category = Category.create!(key: 'nba')
      category.category_translations.create!(language_id: language.id, name: 'NBA')
      conference = category.conferences.create!(key: conference_key)
      conference.conference_translations.create!(language_id: language.id, name: "NBA Conf 1")
      conference.teams.create!(name: team_name)
    end

    context "when given conference_id param" do
      subject(:parsed_response) {JSON.parse(response.body)}
      let(:expected_team_json) { Team.find_by(name: team_name).as_json(except: [:created_at, :updated_at]) }

      before do
        get "/api/v1/teams/teams?conference_id=#{conference_id}"
      end

      it "returns http success status when given conference_id param" do
        expect(response).to have_http_status(:success)
      end

      it "returns teams correct JSON array" do
        expect(response).to match_json_schema("teams")
      end

      it "has corresponding team in JSON array" do
        expect(parsed_response[0]).to eq(expected_team_json)
      end
    end

    context "when no conference_id given" do
      before do
        get "/api/v1/teams/teams"
      end

      it "returns incorrect status" do
        expect(response).to have_http_status(400)
      end
    end

    context "when invalid conference_id given" do
      subject(:parsed_response) {JSON.parse(response.body)}
      let(:invalid_conference_id) {"invalid_id"}

      before do
        get "/api/v1/teams/teams?conference_id=#{invalid_conference_id}"
      end

      it "returns empty JSON" do
        expect(parsed_response).to eq([])
      end
    end

  end

end
