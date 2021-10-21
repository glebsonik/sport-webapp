require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:display_name) }
    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:display_name) }
    it { should validate_uniqueness_of(:key) }
  end
end
