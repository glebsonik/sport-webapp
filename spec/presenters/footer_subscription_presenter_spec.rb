require './app/presenters/footer_subscription_presenter.rb'

RSpec.shared_examples "context subscription" do
  it 'returns expected params for current navigation' do
    expect(subscription_params).to eq(expected)
  end
end

RSpec.describe FooterSubscriptionPresenter, type: :presenter do
  describe '#subscription_params' do
    subject(:subscription_params) { presenter.subscription_params }
    let(:presenter) { described_class.new(params) }

    context 'when on category page' do
      let(:params) { ActionController::Parameters.new(category: 'category_1') }
      let(:expected) do
        {
          subscription_type: :category,
          name: 'category_1'
        }
      end

      include_examples "context subscription"
    end

    context 'when on conference page' do
      let(:params) { ActionController::Parameters.new(conference: 'conference_1') }
      let(:expected) do
        {
          subscription_type: :conference,
          name: 'conference_1'
        }
      end

      include_examples "context subscription"
    end

    context 'when on team page' do
      let(:params) { ActionController::Parameters.new(team: 'team_1') }
      let(:expected) do
        {
          subscription_type: :team,
          name: 'team_1'
        }
      end

      include_examples "context subscription"
    end
  end
end