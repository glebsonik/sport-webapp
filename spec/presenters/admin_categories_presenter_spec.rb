require './app/presenters/admin_categories_presenter.rb'

RSpec.shared_examples "pagination validation" do
  it 'returns empty response' do
    expect(filtered_articles).to eq(expected_articles)
  end
end

RSpec.shared_examples "filtering validation" do
  before do
    expected_translations
  end

  it 'returns empty response' do
    expect(filtered_articles).to eq(expected_translations)
  end
end

RSpec.describe AdminCategoriesPresenter, type: :presenter do
  let(:language) { create(:language) }
  let(:category) { create(:category) }

  let(:category_translation) do
    create(:category_translation, category: category, key: category.key, language: language)
  end
  let(:conferences) do
    create_list(:conference, 2, :with_translation, category: category, language: language)
  end
  let(:teams) do
    [create(:team, conference: conferences[0]), create(:team, conference: conferences[1])]
  end

  before do
    category
    category_translation
    conferences
    teams
    language
  end

  describe "#new" do
    context 'when no category translation found' do
      subject(:new) { described_class.new(incorrect_language_key, category.key)}
      let(:incorrect_language_key) {'incorrect_language_key'}
      let(:expected_error_message) do
        "No category translation found by #{category.key} and #{incorrect_language_key}"
      end

      it 'raises exception if no category translation found' do
        expect{ new }.to raise_error(ArgumentError, expected_error_message)
      end
    end
  end

  describe '#filtered_articles' do
    subject(:filtered_articles) { presenter.filtered_articles(request_params).to_a }

    describe 'pagination' do
      let(:presenter) { described_class.new(language.key, category.key, per_page) }
      let(:per_page) { 2 }
      let(:request_params) { ActionController::Parameters.new(page: page) }

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
        let(:page) { 0 }
        let(:expected_articles) { article_translations.first(per_page) }

        include_examples "pagination validation"
      end

      context 'when second page param given' do
        let(:page) { 1 }
        let(:expected_articles) { article_translations.last(1) }

        include_examples "pagination validation"
      end

      context 'when page with no articles given' do
        let(:page) { 2 }
        let(:expected_articles) { [] }

        include_examples "pagination validation"
      end
    end

    describe 'filtering' do
      let(:presenter) { described_class.new(language.key, category.key, per_page) }
      let(:per_page) { 10 }
      let(:conference_a) { conferences[0] }
      let(:conference_b) { conferences[1] }
      let(:team_a) { teams[0] }
      let(:team_b) { teams[1] }
      let(:article_translation_1) do
        create(:article_translation,
               :with_article,
               :unpublished,
               category: category,
               conference: conference_a,
               team: team_a,
               language: language
        )
      end
      let(:article_translation_2) do
        create(:article_translation,
               :with_article,
               :unpublished,
               category: category,
               conference: conference_a,
               team: team_a,
               language: language
        )
      end
      let(:article_translation_3) do
        create(:article_translation,
               :with_article,
               :published,
               category: category,
               conference: conference_b,
               team: team_b,
               language: language
        )
      end

      let(:article_translations) do
        [
          article_translation_1,
          article_translation_2,
          article_translation_3
        ].reverse
      end

      before do
        article_translations
      end

      context 'when empty params given' do
        let(:request_params) { ActionController::Parameters.new }

        it 'returns not filtered articles' do
          expect(filtered_articles).to eq(article_translations)
        end
      end

      context 'when conference param given' do
        let(:request_params) { ActionController::Parameters.new(conference: expected_conference.id) }
        let(:expected_conference) { conference_a }
        let(:expected_translations) { [article_translation_1, article_translation_2].reverse }

        include_examples "filtering validation"
      end

      context 'when team param given' do
        let(:request_params) { ActionController::Parameters.new(team: expected_team.id) }
        let(:expected_team) { team_b }
        let(:expected_translations) { [article_translation_3] }

        include_examples "filtering validation"
      end

      context 'when published param given' do
        let(:request_params) { ActionController::Parameters.new(published: ArticleTranslation::PUBLISHED) }
        let(:expected_translations) { [article_translation_3] }

        include_examples "filtering validation"
      end

      context 'when multiple filter params given' do
        let(:article_translation_4) do
          create(:article_translation,
                 :with_article,
                 :published,
                 category: category,
                 conference: conference_a,
                 team: team_a,
                 language: language
          )
        end
        let(:article_translation_5) do
          create(:article_translation,
                 :with_article,
                 :published,
                 category: category,
                 conference: conference_a,
                 team: team_a,
                 language: language
          )
        end
        let(:article_translation_6) do
          create(:article_translation,
                 :with_article,
                 :published,
                 category: category,
                 conference: conference_a,
                 team: team_a,
                 language: language
          )
        end
        let(:expected_translations) do
          [
            article_translation_4,
            article_translation_5,
            article_translation_6
          ].reverse
        end

        let(:expected_conference) { conference_a }
        let(:expected_team)       { team_a }
        let(:request_params) do
          ActionController::Parameters.new(
            team: expected_team.id,
            conference: expected_conference.id,
            published: ArticleTranslation::PUBLISHED
          )
        end

        include_examples "filtering validation"
      end
    end
  end

  describe '#conferences_hash' do
    subject(:conferences_hash) { presenter.conferences_hash }
    let(:presenter) { described_class.new(language.key, category.key) }
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

    it 'returns uniq translated conferences { translation_name => conference_id } hash' do
      expect(conferences_hash).to eq(expected_conference_hash)
    end
  end

  describe '#teams_hash' do
    let(:expected_teams_hash) do
      teams.map { |team| [team.name, team.id] }.to_h
    end
    let(:presenter) { described_class.new(language.key, category.key) }
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
      subject(:teams_hash) { presenter.teams_hash }

      it 'returns uniq translated conferences {team_name => team_id} hash' do
        expect(teams_hash).to eq(expected_teams_hash)
      end
    end

    context 'when empty string argument given' do
      subject(:teams_hash) { presenter.teams_hash('') }

      it 'returns uniq translated conferences {team_name => team_id} hash' do
        expect(teams_hash).to eq(expected_teams_hash)
      end
    end

    context 'when conference id argument given' do
      subject(:teams_hash) { presenter.teams_hash(conference_id) }
      let(:conference_id) { conferences[1].id }
      let(:expected_teams_hash) { {teams[1].name => teams[1].id} }

      it 'returns hash with teams related to specified conference id' do
        expect(teams_hash).to eq(expected_teams_hash)
      end
    end
  end
end
