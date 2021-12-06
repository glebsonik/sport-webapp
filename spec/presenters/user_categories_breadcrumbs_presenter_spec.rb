require './app/presenters/user_categories_breadcrumbs_presenter.rb'

RSpec.describe UserCategoriesBreadcrumbsPresenter, type: :presenter do
  let(:navigation) do
    {:categories=>
       [{:key=>"nba",
         :name=>"NBA",
         :conferences=>
           [{:key=>"afc_east",
             :name=>"AFC East",
             :teams=>
               [{:id=>59, :name=>"AFC E3"}]}]
        },
        {:key=>"nfl",
         :name=>"NFL",
         :conferences=>
           [{:key=>"east_division",
             :name=>"East Division",
             :teams=>
               [{:id=>63, :name=>"ED 1"},
                {:id=>64, :name=>"ED 2"},
                {:id=>65, :name=>"ED 3"}]},
            {:key=>"west_division",
             :name=>"West Division",
             :teams=>[{:id=>66, :name=>"WD 1"}, {:id=>67, :name=>"WD 2"}]},
            {:key=>"north_division",
             :name=>"North Division",
             :teams=>[{:id=>68, :name=>"ND 1"}]
            }]
        }
       ]}
  end

  describe '#breadcrumbs' do
    context 'when on category page' do
      subject(:breadcrumbs) {described_class.new(navigation, category_page_params).breadcrumbs}
      let(:category_page_params) do
        ActionController::Parameters.new(category: "nba")
      end
      let(:expected_hash) do
        {
          category: {:key=>"nba", :name=>"NBA"},
          conference: nil,
          team: nil
        }
      end
      it 'returns expected hash for category page' do
        expect(breadcrumbs).to eq(expected_hash)
      end
    end

    context 'when on conference page' do
      subject(:breadcrumbs) {described_class.new(navigation, conference_page_params).breadcrumbs}
      let(:conference_page_params) { ActionController::Parameters.new(category: "nfl", conference: "west_division") }
      let(:expected_hash) do
        {
          category: {:key=>"nfl", :name=>"NFL"},
          conference: {:key=>"west_division", :name=>"West Division"},
          team: nil
        }
      end
      it 'returns expected hash for category page' do
        expect(breadcrumbs).to eq(expected_hash)
      end
    end

    context 'when on team page' do
      subject(:breadcrumbs) {described_class.new(navigation, team_page_params).breadcrumbs}
      let(:team_page_params) do
        ActionController::Parameters.new(category: "nfl", conference: "east_division", team: "64")
      end
      let(:expected_hash) do
        {
          category: {:key=>"nfl", :name=>"NFL"},
          conference: {:key=>"east_division", :name=>"East Division"},
          team: {:id=>64, :name=>"ED 2"}
        }
      end
      it 'returns expected hash for category page' do
        expect(breadcrumbs).to eq(expected_hash)
      end
    end
  end
end