require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'validations' do
    it { should belong_to(:category) }
    it { should have_many(:conference_translations) }
    it { should have_many(:teams) }
    it { should validate_presence_of(:key_name) }
    it { should validate_uniqueness_of(:key_name) }
  end
end
