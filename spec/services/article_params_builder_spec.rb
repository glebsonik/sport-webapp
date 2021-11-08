require './app/services/builders/article_params_builder'

RSpec.describe ArticleParamsBuilder, type: :service do
  describe '#build' do
    subject(:build) {ArticleParamsBuilder.new(params, author.id).build}
    let(:params) {
      ActionController::Parameters.new({category_id: category.id,
                                                    conference_id: conference.id,
                                                    team_id: team.id,
                                                    language_id: language.id,
                                                    location_id: nil,
                                                    picture: fixture_file_upload('files/image.png', 'image/png'),
                                                    alt_image: 'sample text',
                                                    headline: 'headline',
                                                    caption: 'caption',
                                                    content: 'Some <b>content</b> goes here'})
    }
    let(:category) { Category.create!(key: 'nba') }
    let(:conference) { category.conferences.create!(key: 'nba_conf_1') }
    let(:team) { conference.teams.create!(name: 'Team 1') }
    let(:language) { Language.create!(key: 'en', display_name: 'English', hidden: false) }
    let(:author) {User.create!(user_name: 'name', email: 'test@email.com', password: '123456Tr',
                               role: UserStatuses::ADMIN, status: UserStatuses::ACTIVE)}

    it 'returns hash' do
      expect(build).to be_instance_of Hash
    end

    it 'returns hash that can be used to build article' do
      expect(Article.new(build)).to be_valid
    end

    it 'returns hash that can be used to build nested article translation' do
      expect(Article.new(build).article_translations[0]).to be_valid
    end
  end
end