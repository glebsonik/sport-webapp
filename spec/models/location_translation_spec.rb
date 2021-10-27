require 'rails_helper'

RSpec.describe LocationTranslation, type: :model do
  describe 'relations' do
    it { should belong_to(:conference) }
    it { should belong_to(:language) }
  end
end
