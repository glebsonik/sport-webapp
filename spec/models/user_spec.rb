RSpec.describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:user_name)}
    it {should validate_uniqueness_of(:user_name)}
    it {should have_secure_password}
    it {should validate_length_of(:password).is_at_least(6)}
    it {should validate_length_of(:password).is_at_most(20)}
  end

  describe 'email validations' do
    subject { User.new }
    let(:valid_email) { "valid_email@gmail.com" }
    let(:invalid_emails) {['fff', 'vvv_vvv', 'vvv@']}

    it "allows valid email" do
      expect(subject).to allow_value(valid_email).for(:email)
    end

    it "rejects invalid emails" do
      invalid_emails.each do |invalid_example|
        expect(subject).not_to allow_value(invalid_example).for(:email)
      end
    end
  end

end
