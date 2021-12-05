require './app/services/builders/user_navigation_builder.rb'

#TODO: discuss is that enough for testing or how can we expand this example
# My opinion that it should be expanded by increasing conferences to 4 (2 for each category)
# Usage of a helper method?

RSpec.describe UserNavigationBuilder, type: :service do
  describe "#build" do
    subject(:build) {UserNavigationBuilder.new(language).build}
    let(:categories) { create_list(:category, 2, :with_translation, language: language) }
    let(:conferences) do
      [
      create(:conference, :with_translation, category: categories[0], language: language),
      create(:conference, :with_translation, category: categories[1], language: language)
      ]
    end
    let(:teams) do
      [
        create(:team, conference: conferences[0]),
        create(:team, conference: conferences[1])
      ]
    end
    let(:language) { create(:language) }

    let(:expected) do
      {categories: [
        { key: categories[0].key,
          name: categories[0].category_translations[0].name,
          conferences: [
            {
              key: conferences[0].key,
              name: conferences[0].conference_translations[0].name,
              teams: [
                { id: teams[0].id,
                  name: teams[0].name }
              ]
            }
          ] },
        { key: categories[1].key,
          name: categories[1].category_translations[0].name,
          conferences: [
            {
              key: conferences[1].key,
              name: conferences[1].conference_translations[0].name,
              teams: [
                { id: teams[1].id,
                  name: teams[1].name }
              ]
            }
          ] }
      ]}
    end

    before do
      language
      categories
      conferences
      teams
    end

    it "returns expected navigation structure" do
      expect(build).to eq(expected)
    end
  end
end
