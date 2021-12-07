require './app/services/builders/user_navigation_builder.rb'

RSpec.describe UserNavigationBuilder, type: :service do
  describe "#build" do
    subject(:build) {UserNavigationBuilder.new(language).build}
    let(:categories) { create_list(:category, 2, :with_translation, language: language) }
    let(:conferences) do
      [
      create(:conference, :with_translation, category: categories[0], language: language),
      create(:conference, :with_translation, category: categories[0], language: language),
      create(:conference, :with_translation, category: categories[1], language: language),
      ]
    end
    let(:teams) do
      [
        create(:team, conference: conferences[0]),
        create(:team, conference: conferences[0]),
        create(:team, conference: conferences[1]),
        create(:team, conference: conferences[2])
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
                  name: teams[0].name },
                { id: teams[1].id,
                  name: teams[1].name },
              ]
            },
            {
              key: conferences[1].key,
              name: conferences[1].conference_translations[0].name,
              teams: [
                { id: teams[2].id,
                  name: teams[2].name }
              ]
            }
          ] },
        { key: categories[1].key,
          name: categories[1].category_translations[0].name,
          conferences: [
            {
              key: conferences[2].key,
              name: conferences[2].conference_translations[0].name,
              teams: [
                { id: teams[3].id,
                  name: teams[3].name }
              ]
            }
          ] },
      ]}
    end

    before do
      language
      categories
      conferences
      teams
    end

    it "returns expected navigation structure without unfinished navigation" do
      expect(build).to eq(expected)
    end
  end
end
