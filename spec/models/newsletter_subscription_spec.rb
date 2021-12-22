require 'rails_helper'

RSpec.describe NewsletterSubscription, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:subscription_type) }
  end
end
