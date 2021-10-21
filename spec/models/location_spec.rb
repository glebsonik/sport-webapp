require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { should have_many(:location_translation) }
    it { should validate_presence_of(:key_name) }
    it { should validate_uniqueness_of(:key_name) }
  end
end
