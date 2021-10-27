require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'relations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should belong_to(:category) }
    it { should belong_to(:conference) }
    it { should belong_to(:team).optional }
    it { should belong_to(:location).optional }
    it { should have_many(:article_translations) }
  end

  describe 'nesting' do
    it { should accept_nested_attributes_for(:article_translations) }
  end
end
