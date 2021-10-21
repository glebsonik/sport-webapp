require 'rails_helper'

RSpec.describe ConferenceTranslation, type: :model do
  describe 'validations' do
    it { should belong_to(:conference) }
    it { should belong_to(:language) }
    it { should validate_presence_of(:name) }
    it { should delegate_method(:key_name).to(:conference) }
  end
end
