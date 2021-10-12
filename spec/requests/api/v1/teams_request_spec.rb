require 'rails_helper'

RSpec.describe "Api::V1::Teams", type: :request do

  describe "GET /teams" do
    it "returns http success" do
      get "/api/v1/teams/teams"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /by_id" do
    it "returns http success" do
      get "/api/v1/teams/by_id"
      expect(response).to have_http_status(:success)
    end
  end

end
