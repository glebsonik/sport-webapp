require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do

  describe "GET /categories" do
    it "returns http success" do
      get "/api/v1/categories/categories"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /translated_categories" do
    it "returns http success" do
      get "/api/v1/categories/categories"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /category_by_id" do
    it "returns http success" do
      get "/api/v1/categories/category_by_id"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /translated_category_by_id" do
    it "returns http success" do
      get "/api/v1/categories/category_by_id"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /translated_by_key_name" do
    it "returns http success" do
      get "/api/v1/categories/category_by_id"
      expect(response).to have_http_status(:success)
    end
  end

end
