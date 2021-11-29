RSpec.describe Api::V1::AdminCategoriesController, type: :request do

  describe "GET /admin_categories/:key/articles" do
    let(:articles_translations) do
      create_list(:article_translation, 3,
                  :with_article, category: category, conference: conference, team: team, language: language)
    end
    let(:category) { create(:category) }
    let(:category_translation) {create(:category_translation, category: category, key: category.key, language: language)}
    let(:conference) { create(:conference, category: category) }
    let(:language) { create(:language) }
    let(:team) { create(:team, conference: conference) }
    let(:expected) { {count: articles_translations.size, last: true} }
    before do
      category
      category_translation
      conference
      team
      language
      articles_translations
      get "/api/v1/admin_categories/#{category.key}/articles?language_key=#{language.key}"
    end

    it 'returns http success status' do
      expect(response).to have_http_status(:success)
    end

    it 'returns correct JSON' do
      expect(response).to match_json_schema('admin_articles')
    end

    it 'has corresponding team in JSON array' do
      expect(result[:articles]).not_to be_nil
      expect(result[:count]).to eq(expected[:count])
      expect(result[:last]).to eq(expected[:last])
    end
  end
end
