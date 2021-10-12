require 'rails_helper'

RSpec.describe "Api::V1::Conferences", type: :request do

  describe "GET /conferences" do
    it "returns http success" do
      get "/api/v1/conferences/conferences"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /translated" do
    it "returns http success" do
      get "/api/v1/conferences/translated"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /by_id" do
    it "returns http success" do
      get "/api/v1/conferences/by_id"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /translated_by_id" do
    it "returns http success" do
      get "/api/v1/conferences/translated_by_id"
      expect(response).to have_http_status(:success)
    end
  end

end
