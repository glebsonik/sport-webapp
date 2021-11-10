require 'rails_helper'

RSpec.describe CategoryTranslation, type: :model do
  describe 'relations' do
    it { should belong_to(:category) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#translation_for' do
    subject(:translation_for_category) { described_class.translation_for(category_key, language_key) }
    let(:translated_category_name) { 'NBA' }
    let(:category_key) { 'nba' }
    let(:language_key) { 'en' }

    let(:language) do
      Language.create(
        key: language_key,
        display_name: 'English'
      )
    end
    let(:category) do
      Category.create(key: category_key)
    end
    let(:category_translation) do
      CategoryTranslation.create(
        language: language,
        name: translated_category_name,
        key: category_key,
        category: category
      )
    end

    before do
      language
      category
      category_translation
    end

    it 'returns category translation by language and category key' do
      expect(translation_for_category.name).to        eq(translated_category_name)
      expect(translation_for_category.language_id).to eq(language.id)
      expect(translation_for_category.category_id).to eq(category.id)
    end
  end
end