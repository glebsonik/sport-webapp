require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'relations' do
    it { should belong_to(:category) }
    it { should have_many(:conference_translations) }
    it { should have_many(:teams) }
  end

  describe 'validations' do
    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
  end
end
