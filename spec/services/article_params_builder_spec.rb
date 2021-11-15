require './app/services/builders/article_params_builder'

RSpec.describe ArticleParamsBuilder, type: :service do
  describe '#build' do
    subject(:build) { described_class.new(params, author).build }

    let(:params) do
      ActionController::Parameters.new(
        category_id: category.id,
        conference_id: conference.id,
        team_id: team.id,
        language_id: language.id,
        location_id: nil,
        picture: picture,
        alt_image: 'sample text',
        headline: 'headline',
        caption: 'caption',
        content: 'Some <b>content</b> goes here'
      )
    end

    let(:category)    { create(:category) }
    let(:conference)  { create(:conference, category: category) }
    let(:team)        { create(:team, conference: conference) }
    let(:language)    { create(:language) }
    let(:author)      { create(:user, :admin) }
    let(:picture)     { fixture_file_upload('files/image.png', 'image/png') }
    let(:expected_hash) do
      {
        category_id:   category.id,
        conference_id: conference.id,
        team_id:       team.id,
        location_id:   nil,
        author_id:     author.id,
        article_translations_attributes: [{
                                            language_id:   language.id,
                                            picture:       picture,
                                            alt_image:     'sample text',
                                            headline:      'headline',
                                            caption:       'caption',
                                            content:       'Some <b>content</b> goes here',
                                            show_comments: true,
                                            status:        Article::UNPUBLISHED
                                          }]
      }
    end

    before do
      allow_any_instance_of(described_class).to receive(:sanitize_bool).with(anything) do
        true
      end
    end

    it 'returns hash' do
      expect(build).to be_instance_of Hash
    end

    it 'returns hash that can be used to build article' do
      expect(Article.new(build)).to be_valid
    end

    it 'returns hash that can be used to build nested article translation' do
      expect(Article.new(build).article_translations[0]).to be_valid
    end

    it 'returns properly mapped hash' do
      expect(build).to eq(expected_hash)
    end
  end
end