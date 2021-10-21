require 'rails_helper'

RSpec.describe LocationTranslation, type: :model do
  describe 'validations' do
    it { should belong_to(:conference) }
    it { should belong_to(:language) }
  end
end
