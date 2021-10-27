require 'rails_helper'

RSpec.describe ConferenceTranslation, type: :model do
  describe 'relations' do
    it { should belong_to(:conference) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'delegations' do
    it { should delegate_method(:key_name).to(:conference) }
  end
end
