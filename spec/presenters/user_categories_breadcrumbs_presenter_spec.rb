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
    subject(:breadcrumbs) {described_class.new(navigation, page_params).breadcrumbs}

    context 'when on category page' do
      let(:page_params) do
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
      let(:page_params) { ActionController::Parameters.new(category: "nfl", conference: "west_division") }
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
      let(:page_params) do
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