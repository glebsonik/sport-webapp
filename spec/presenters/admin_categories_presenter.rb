require './app/presenters/admin_categories_presenter.rb'

RSpec.describe AdminCategoriesPresenter, type: :presenter do
  let(:category) { create(:category) }
  let(:category_translation) {create(:category_translation, category: category, key: category.key, language: language)}
  let(:conferences) { create_list(:conference, 2, :with_translation, category: category, language: language) }
  let(:language) { create(:language) }
  let(:teams) { [create(:team, conference: conferences[0]), create(:team, conference: conferences[1])] }

  before do
    category
    category_translation
    conferences
    teams
    language
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
    subject(:articles) {AdminCategoriesPresenter.new(language.key, category.key).articles.to_a}
    let(:actual_article) { articles.first }
    let(:expected_article_translations) do
      [
        create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
        create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
        create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language)
      ].reverse
    end
    let(:unrelated_articles) { create_list(:article_translation, 2, :with_article, language: language) }

    before do
      expected_article_translations
    end

    it 'returns articles related to category' do
      expect(articles).to match_array(expected_article_translations)
    end

    it 'returns articles order by desc created at time' do
      expect(articles).to eq(expected_article_translations)
    end

    it 'does not return articles for other category' do
      expect(articles).not_to include(*unrelated_articles)
    end

    it 'returns models with correct attributes' do
      expect(actual_article.team_name).to eq(teams[1].name)
      expect(actual_article.category_name).to eq(category_translation.name)
      expect(actual_article.article_id).to eq(actual_article.article.id)

      expect(actual_article.headline).not_to be_nil
      expect(actual_article.content).not_to be_nil
      expect(actual_article.caption).not_to be_nil
      expect(actual_article.alt_image).not_to be_nil
      expect(actual_article.picture).not_to be_nil
    end
  end

  describe '#filtered_articles' do

    describe 'pagination' do
      let(:articles_per_page) { 2 }
      let(:article_translations) do
        [
          create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
          create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
          create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
        ].reverse
      end

      before do
        article_translations
      end

      context 'when first page param given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key, articles_per_page)
                                  .filtered_articles(params_with_first_page).to_a
        end
        let(:params_with_first_page) {ActionController::Parameters.new(page: 0)}
        let(:expected_for_first_page) {article_translations.first(articles_per_page)}

        it 'returns articles for the first page' do
          expect(filtered_articles).to eq(expected_for_first_page)
        end
      end

      context 'when second page param given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key, articles_per_page)
                                  .filtered_articles(params_with_second_page).to_a
        end
        let(:params_with_second_page) {ActionController::Parameters.new(page: 1)}
        let(:expected_for_second_page) { article_translations[articles_per_page..(articles_per_page * 2) - 1] }

        it 'returns articles for the first page' do
          expect(filtered_articles).to eq(expected_for_second_page)
        end
      end

      context 'when empty page param given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key, articles_per_page)
                                  .filtered_articles(params_with_empty_page).to_a
        end
        let(:params_with_empty_page) {ActionController::Parameters.new(page: 2)}

        it 'returns empty response' do
          expect(filtered_articles).to eq([])
        end
      end
    end

    describe 'filtering' do
      context 'when empty params given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key)
                                  .filtered_articles(empty_params).to_a
        end
        let(:empty_params) {ActionController::Parameters.new}
        let(:expected_article_translations) do
          [
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language)
          ].reverse
        end

        before do
          expected_article_translations
        end

        it 'returns not filtered articles' do
          expect(filtered_articles).to eq(expected_article_translations)
        end
      end

      context 'when conference param given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key)
                                  .filtered_articles(params_conference).to_a
        end
        let(:params_conference) {ActionController::Parameters.new(conference: expected_conference.id)}
        let(:expected_conference) { conferences[0] }
        let(:expected_translations) do
          article_translations.find_all { |translation| translation.article.conference == expected_conference }
          article_translations.find_all { |translation| translation.article.conference == expected_conference }
        end
        let(:article_translations) do
          [
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language)
          ].reverse
        end

        before do
          expected_translations
        end

        it 'returns filtered articles' do
          expect(filtered_articles).to eq(expected_translations)
        end
      end

      context 'when team param given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key)
                                  .filtered_articles(params_team).to_a
        end
        let(:params_team) { ActionController::Parameters.new(team: expected_team.id) }
        let(:expected_team) { teams[1] }
        let(:expected_article_translations) do
          article_translations.find_all{|translation| translation.article.team == expected_team}
        end
        let(:article_translations) do
          [
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
          ].reverse
        end

        before do
          expected_article_translations
        end

        it 'returns articles for specific team for first page' do
          expect(filtered_articles).to match_array(expected_article_translations)
        end
      end

      context 'when published param given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key)
                                  .filtered_articles(params_team).to_a
        end
        let(:params_team) { ActionController::Parameters.new(published: ArticleTranslation::PUBLISHED) }
        let(:expected_article_translations) do
          article_translations.find_all{|translation| translation.published?}
        end
        let(:article_translations) do
          [
            create(:article_translation, :with_article, :published, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, :published, category: category, conference: conferences[1], team: teams[1], language: language),
          ].reverse
        end

        before do
          expected_article_translations
        end

        it 'returns published articles' do
          expect(filtered_articles).to match_array(expected_article_translations)
        end
      end

      context 'when multiple filter params given' do
        subject(:filtered_articles) do
          AdminCategoriesPresenter.new(language.key, category.key)
                                  .filtered_articles(params_multiple_sort).to_a
        end
        let(:expected_conference) { conferences[0] }
        let(:expected_team) { teams[0] }
        let(:params_multiple_sort) { ActionController::Parameters.new(team: expected_team.id,
                                                                      conference: expected_conference.id,
                                                                      published: ArticleTranslation::PUBLISHED) }
        let(:expected_article_translations) do
          article_translations.find_all do |translation|
            translation.article.team == expected_team &&
              translation.article.conference == expected_conference &&
              translation.published?
          end
        end
        let(:article_translations) do
          [
            create(:article_translation, :with_article, :published, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
            create(:article_translation, :with_article, :published, category: category, conference: conferences[1], team: teams[1], language: language),
          ].reverse
        end

        before do
          expected_article_translations
        end

        it 'returns filtered articles translations' do
          expect(filtered_articles).to eq(expected_article_translations)
        end
      end
    end
  end

  describe '#conferences_hash' do
    subject(:conferences_hash) { AdminCategoriesPresenter.new(language.key, category.key).conferences_hash }
    let(:article_translations) do
      [
        create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
        create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
        create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language)
      ].reverse
    end
    let(:expected_conference_hash) do
      conferences.map do |conference|
        [conference.conference_translations[0].name, conference.id]
      end.to_h
    end

    before do
      article_translations
    end

    it 'returns uniq translated conferences {translation_name => conference_id} hash' do
      expect(conferences_hash).to eq(expected_conference_hash)
    end
  end

  describe '#teams_hash' do
    let(:expected_teams_hash) do
      teams.map { |team| [team.name, team.id] }.to_h
    end
    let(:article_translations) do
      [
        create(:article_translation, :with_article, category: category, conference: conferences[0], team: teams[0], language: language),
        create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language),
        create(:article_translation, :with_article, category: category, conference: conferences[1], team: teams[1], language: language)
      ].reverse
    end

    before do
      article_translations
    end

    context 'when no argument given' do
      subject(:teams_hash) { AdminCategoriesPresenter.new(language.key, category.key).teams_hash }

      it 'returns uniq translated conferences {team_name => team_id} hash' do
        expect(teams_hash).to eq(expected_teams_hash)
      end
    end

    context 'when empty string argument given' do
      subject(:teams_hash) { AdminCategoriesPresenter.new(language.key, category.key).teams_hash('') }

      it 'returns uniq translated conferences {team_name => team_id} hash' do
        expect(teams_hash).to eq(expected_teams_hash)
      end
    end

    context 'when conference id argument given' do
      subject(:teams_hash) { AdminCategoriesPresenter.new(language.key, category.key).teams_hash(conference_id) }
      let(:conference_id) {conferences[1].id}
      let(:expected_teams_hash) { {teams[1].name => teams[1].id} }

      it 'returns hash with teams related to specified conference id' do
        expect(teams_hash).to eq(expected_teams_hash)
      end
    end
  end
end