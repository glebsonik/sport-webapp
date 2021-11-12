RSpec.describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:user_name)}
    it {should validate_uniqueness_of(:user_name)}
    it {should have_secure_password}
    it {should validate_length_of(:password).is_at_least(6)}
    it {should validate_length_of(:password).is_at_most(20)}

    describe 'user statuses validation' do
      let(:allowed_status_values) { Hash.new(active: 'active',
                             email_pending: 'email_pending',
                             blocked: 'blocked') }

      it {should define_enum_for(:status).with_values(allowed_status_values).backed_by_column_of_type(:string) }
    end

    describe 'user roles validation' do
      let(:allowed_roles) { Hash.new(admin: 'admin', member: 'member')}

      it {should define_enum_for(:role).with_values(allowed_roles).backed_by_column_of_type(:string)}
    end
  end

  describe 'email validations' do
    subject { User.new }
    let(:valid_email) { "valid_email@gmail.com" }
    let(:invalid_emails) {['fff', 'vvv_vvv', 'vvv@']}

    it "allows valid email" do
      expect(subject).to allow_value(valid_email).for(:email)
    end

    #TODO: Replace with shared examples
    it "rejects invalid emails" do
      invalid_emails.each do |invalid_example|
        expect(subject).not_to allow_value(invalid_example).for(:email)
      end
    end
  end

end
