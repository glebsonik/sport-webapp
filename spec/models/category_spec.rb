require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should have_many(:category_translations) }
    it { should have_many(:conferences) }
    it { should validate_presence_of(:key_name) }
    it { should validate_uniqueness_of(:key_name) }
  end

  describe '.translation_for' do

  end

end
