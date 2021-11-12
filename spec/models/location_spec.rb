require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'relations' do
    it { should have_many(:location_translation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
  end
end
