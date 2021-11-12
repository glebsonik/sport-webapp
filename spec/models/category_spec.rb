require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'relations' do
    it { should have_many(:category_translations) }
    it { should have_many(:conferences) }
  end

  describe 'validations' do
    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
  end
end
