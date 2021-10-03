RSpec.describe User, type: :model do

  it "valid with email, user_name, password and equal confirmation" do
    valid_user = User.new(email: 'correct_email@gmail.com',
                           user_name: 'valid_name',
                           password: 'some_pswd',
                           password_confirmation: 'some_pswd')
    expect(valid_user).to be_valid
  end

  it "valid with email, user_name and password" do
    valid_user = User.new(email: 'correct_email@gmail.com',
                          user_name: 'valid_name',
                          password: 'some_pswd')
    expect(valid_user).to be_valid
  end

  it "invalid without params" do
    expect(User.new).not_to be_valid
  end

  it "invalid without user_name" do
    no_user_name_user = User.new(email:'valid@email.com', password: 'some_pswd', password_confirmation: 'some_pswd')
    expect(no_user_name_user).not_to be_valid
  end

  it "invalid without email" do
    expect(User.new(user_name: 'aboba', password: 'some_pswd')).not_to be_valid
  end

  it "invalid with incorrect email" do
    incorrect_emails = ['broke', 'em@', 'em@', 'asdf@asdf', 'tu@s.s']

    incorrect_emails.each do |incorrect_email|
      expect(User.new(email: incorrect_email, user_name: 'aboba', password: 'some_pswd')).not_to be_valid
    end
  end

  describe "password validation" do
    it "invalid without password" do
      no_password_user = User.new(email:'valid@email.com', user_name: 'aboba', password_confirmation: 'passwrd')
      expect(no_password_user).not_to be_valid
    end

    it "invalid with not similar password and confirmation" do
      no_match_pass_user = User.new(email:'valid@email.com',
                                  user_name: 'aboba',
                                  password: 'password',
                                  password_confirmation: 'drowssap')
      expect(no_match_pass_user).not_to be_valid
    end

    it "invalid with short password" do
      expect(User.new(email: 'correct_email@bebra.com', user_name: 'aboba', password: '1234')).not_to be_valid
    end

    it "invalid with long password" do
      long_password = '1'*50
      expect(User.new(email: 'correct_email@bebra.com', user_name: 'aboba', password: long_password)).not_to be_valid
    end
  end

end
