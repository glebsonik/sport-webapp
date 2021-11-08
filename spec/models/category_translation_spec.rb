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
    subject(:translation_for_category) { CategoryTranslation.translation_for(category_key, language.key) }
    let(:category_key) { 'nba' }
    let(:translated_category_name) { 'NBA' }
    let(:language_key) { 'en' }
    let(:language) {Language.find_by(key: language_key)}

    before do
      Language.create!(key: language_key, display_name: 'English')
      category = Category.find_or_create_by!(key: category_key)
      category.category_translations.find_or_create_by!(language_id: language.id,
                                           name: translated_category_name)
    end

    it 'returns category translation by language and category key' do
      expect(translation_for_category.name).to eq(translated_category_name)
      expect(translation_for_category.language_id).to eq(language.id)
    end
  end

end
