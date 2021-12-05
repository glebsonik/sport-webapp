require './app/presenters/user_categories_presenter.rb'

RSpec.describe UserCategoriesPresenter, type: :presenter do
  let(:category) { create(:category) }
  let(:conference) { create(:conference, category: category) }
  let(:team) { create(:team, conference: conference) }
  let(:language) { create(:language) }

  before do
    language
    category
    conference
    team
  end

  describe '#articles' do
    let(:presenter) { UserCategoriesPresenter.new(language.key, category.key, articles_per_page) }
    let(:articles_per_page) {10}

    describe 'articles fetching' do
      subject(:articles) {presenter.articles(params)}
      let(:params) {ActionController::Parameters.new}
      let(:unrelated_conference) { create(:conference, category: category) }
      let(:expected_articles) do
        create_list(:article_translation, 3, :with_article, :published,
                    language: language, category: category,
                    conference: unrelated_conference, team: create(:team, conference: unrelated_conference)
        )
      end
      let(:unrelated_articles) do
        create_list(:article_translation, 2, :with_article, :unpublished,
                    language: language, category: category, conference: conference, team: team)
      end

      before do
        expected_articles
        unrelated_articles
      end

      it 'returns published articles for category' do
        expect(articles).to match_array(expected_articles)
      end

      it 'returns articles ordered by creation date descendant' do
        expect(articles).to eq(expected_articles.reverse)
      end
    end

    describe 'conference and team filtering' do
      context 'when conference key param given' do
        subject(:articles) {presenter.articles(params_with_conference)}
        let(:params_with_conference) {ActionController::Parameters.new(conference: conference.key)}
        let(:unrelated_conference) { create(:conference, category: category) }
        let(:expected_articles) do
          create_list(:article_translation, 3, :with_article, :published,
                      language: language, category: category,
                      conference: conference, team: create(:team, conference: conference)
          ).reverse
        end
        let(:unrelated_articles) do
          create_list(:article_translation, 2, :with_article, :unpublished,
                      language: language, category: category,
                      conference: unrelated_conference, team: create(:team, conference: unrelated_conference))
        end

        before do
          expected_articles
          unrelated_articles
        end

        it 'returns articles for expected conference' do
          expect(articles).to eq(expected_articles)
        end
      end

      context 'when conference key and team id params given' do
        subject(:articles) {presenter.articles(params_with_team)}
        let(:params_with_team) {ActionController::Parameters.new(conference: conference.key, team: team.id)}
        let(:expected_articles) do
          create_list(:article_translation, 3, :with_article, :published,
                      language: language, category: category, conference: conference, team: team
          ).reverse
        end
        let(:unrelated_articles) do
          create_list(:article_translation, 2, :with_article, :unpublished,
                      language: language, category: category, conference: conference,
                      team: create(:team, conference: unrelated_conference))
        end
        let(:unrelated_conference) { create(:conference, category: category) }

        before do
          expected_articles
          unrelated_articles
        end

        it 'returns articles for expected team' do
          expect(articles).to eq(expected_articles)
        end
      end
    end

    describe 'page navigation' do
      let(:presenter) { UserCategoriesPresenter.new(language.key, category.key, articles_per_page) }
      let(:articles_per_page) {2}
      let(:articles_records) do
        create_list(:article_translation, 3, :with_article, :published,
                    language: language, category: category, conference: conference, team: team).reverse
      end
      let(:unrelated_articles_records) do
        create_list(:article_translation, 2, :with_article, :unpublished,
                    language: language, category: category, conference: conference, team: team)
      end

      before do
        articles_records
        unrelated_articles_records
      end

      context 'when no page given' do
        subject(:articles) { presenter.articles(empty_params) }
        let(:empty_params) { ActionController::Parameters.new }
        let(:expected_articles) { articles_records.first(articles_per_page) }

        it 'returns articles for first page' do
          expect(articles).to eq(expected_articles)
        end
      end

      context 'when first page param given' do
        subject(:articles) { presenter.articles(params_with_first_page) }
        let(:params_with_first_page) { ActionController::Parameters.new(page: 0) }
        let(:expected_articles) { articles_records.first(articles_per_page) }

        it 'returns articles for first page' do
          expect(articles).to eq(expected_articles)
        end
      end

      context 'when second page param given' do
        subject(:articles) { presenter.articles(params_with_second_page) }
        let(:params_with_second_page) { ActionController::Parameters.new(page: 1) }
        let(:expected_articles) { articles_records[articles_per_page..-1] }

        it 'returns articles for second page' do
          expect(articles).to eq(expected_articles)
        end
      end

      context 'when page with no articles given' do
        subject(:articles) { presenter.articles(params_for_empty_page) }
        let(:params_for_empty_page) { ActionController::Parameters.new(page: 3) }

        it 'returns articles for empty page' do
          expect(articles).to eq([])
        end
      end
    end
  end
end
