require 'rspec/mocks'

DEFAULT_DATA_DELIMITER = ';;;'

RSpec.describe UserMailDataProcessor, type: :service do

  before(:example) do
    @user = double(user_name: 'test_user')
    @processor = UserMailDataProcessor.new(DEFAULT_DATA_DELIMITER)
  end

  describe "#get_encrypted_payload and #get_user_params" do
    it 'Returns encrypted payload that can be decrypted with returning params' do
      time_before_payload = Time.zone.now

      payload = @processor.get_encrypted_payload(@user)
      user_params = @processor.get_user_params(payload)

      time_after_payload = Time.zone.now
      actual_payload_time = Time.parse(user_params[:created_at])

      expect(actual_payload_time.to_i).to be_between(time_before_payload.to_i, time_after_payload.to_i).inclusive
      expect(user_params[:user_name]).to eq(@user.user_name)
    end
  end

  describe "#payload_valid?" do
    context "when given valid payload" do
      it "returns true" do
        payload = @processor.get_encrypted_payload(@user)

        expect(@processor.payload_valid?(payload)).to eq true
      end
    end

    context "when given invalid payload" do
      it "returns false" do
        payload = "incorrect:payload"

        expect(@processor.payload_valid?(payload)).to eq false
      end
    end
  end

end