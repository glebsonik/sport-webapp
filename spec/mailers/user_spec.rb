require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe ".confirmation_email" do
    subject(:user_deliver_email) {UserMailer.with(user: user).confirmation_email.deliver_now}
    let(:user) {double(email: 'test_user@gmail.com', user_name: "aboba")}
    let(:correct_url) {
      "http://localhost:3000/email_confirmation/show?payload=nM%2F%2B6fgbGNE8CTdmIHzusJMlU%2F67YKzh9aT2eicjk%2BLFPE7pJMHq1D0%3D--ctVhF2yQl4lRNn4k--aBRBPqKCVYSa9XvNvjr%2FjA%3D%3D"
    }

    before do
      allow_any_instance_of(UserMailer).to receive(:confirmation_url).with(anything) do
        correct_url
      end
    end

    it "sends email with user param" do
      expect { user_deliver_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "sends email using user email" do
      expect(user_deliver_email.to).to eq([user.email])
    end
  end
end
