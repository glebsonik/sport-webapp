require 'rails_helper'

RSpec.shared_examples "user categories api request validation" do
  it "returns http success" do
    expect(response).to have_http_status(:success)
  end

  it "returns expected JSON" do
    expect(response).to match_json_schema('user_categories_articles')
  end

  it "returns JSON with expected data" do
    expect(result["articles"]).not_to be_blank
    expect(result["count"]).to eq(expected[:count])
    expect(result["last"]).to eq(expected[:last])
  end
end

RSpec.describe Api::V1::UserCategoriesController, type: :request do
  subject(:result) {JSON.parse(response.body)}
  let(:language) { create(:language) }
  let(:category) { create(:category) }
  let(:conference) { create(:conference, category: category) }
  let(:team) { create(:team, conference: conference) }
  let(:articles_translations) do
    create_list(:article_translation, 3, :with_article, :published,
                category: category, conference: conference, team: team, language: language)
  end
  let(:expected) { {count: articles_translations.size, last: true} }

  before do
    language
    category
    conference
    team
    articles_translations
  end
  describe "GET user_categories/:category'" do

    before do
      get "/api/v1/user_categories/#{category.key}?language_key=#{language.key}"
    end

    include_examples "user categories api request validation"
  end

  describe "GET user_categories/:category/:conference" do
    before do
      get "/api/v1/user_categories/#{category.key}/#{conference.key}?language_key=#{language.key}"
    end

    include_examples "user categories api request validation"
  end

  describe "GET user_categories/:category/:conference/:team" do
    before do
      get "/api/v1/user_categories/#{category.key}/#{conference.key}/#{team.id}?language_key=#{language.key}"
    end

    include_examples "user categories api request validation"
  end
end
