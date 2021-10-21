require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { should belong_to(:conference) }
    it { should belong_to(:location).optional }
    it { should validate_presence_of(:name) }
  end
end
