require 'rails_helper'

RSpec.describe ArticleTranslation, type: :model do

  describe 'relations' do
    it { should belong_to(:article) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    it { should validate_presence_of(:picture) }
    it { should validate_presence_of(:alt_image) }
    it { should validate_presence_of(:caption) }
    it { should validate_presence_of(:headline) }
    it { should validate_presence_of(:content) }

    describe 'status validations' do
      let(:allowed_values) {Hash.new(unpublished: 'unpublished', published: 'published')}

      it {should define_enum_for(:status).with_values(allowed_values).backed_by_column_of_type(:string) }
    end
  end
end
