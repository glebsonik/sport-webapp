require 'rails_helper'

RSpec.describe CategoryTranslation, type: :model do
  describe 'validations' do
    it {should belong_to(:category)}
    it {should belong_to(:language)}
    it {should validate_presence_of(:name)}
    it { should delegate_method(:key_name).to(:category) }
  end
end
