require './app/presenters/admin_categories_presenter.rb'

RSpec.describe AdminCategoriesPresenter, type: :presenter do
  let(:category) { create(:category) }
  let(:category_translation) {create(:category_translation, category: category, key: category.key, language: language)}
  let(:conferences) { create_list(:conference, 2, category: category) }
  let(:language) { create(:language) }
  let(:teams) { [create(:team, conference: conferences[0]), create(:team, conference: conferences[1])] }
  let(:expected_article_translations) do
    [create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
     create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language)]
  end
  let(:unrelated_articles) { create_list(:article_translation, 2, :with_article, language: language) }

  before do
    category
    category_translation
    conferences
    teams
    expected_article_translations
    language
    unrelated_articles
  end

  describe "#new" do
    context 'when no category translation found' do
      subject(:new) {AdminCategoriesPresenter.new(incorrect_language_key, category.key)}
      let(:incorrect_language_key) {'uk'}
      let(:expected_error_message) {"No category translation found by #{category.key} and #{incorrect_language_key}"}

      it 'raises exception if no category translation found' do
        expect{ new }.to raise_error(ArgumentError, expected_error_message)
      end
    end
  end

  describe "#articles" do
    subject(:articles) {AdminCategoriesPresenter.new(language.key, category.key).articles}
    let(:actual_article) { articles[0] }

    it 'returns articles related to category' do
      expect(articles).to match_array(expected_article_translations)
    end

    it 'does not return articles for other category' do
      expect(articles).not_to include(*unrelated_articles)
    end



    it 'returns models with correct attributes' do
      expect(actual_article.team_name).to eq(teams[0].name)
      expect(actual_article.category_name).to eq(category_translation.name)
      expect(actual_article.article_id).to eq(actual_article.article.id)

      expect(actual_article.headline).not_to be_nil
      expect(actual_article.content).not_to be_nil
      expect(actual_article.caption).not_to be_nil
      expect(actual_article.alt_image).not_to be_nil
      expect(actual_article.picture).not_to be_nil
    end
  end
end