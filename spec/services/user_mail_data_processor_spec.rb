require 'rspec/mocks'
require './app/services/user_mail_data_processor.rb'

RSpec.describe UserMailDataProcessor, type: :service do
  subject(:data_processor) { UserMailDataProcessor.new }
  let(:user_double) { double(user_name: 'test_user') }
  let(:data_delimiter) { UserMailDataProcessor::DEFAULT_DATA_DELIMITER}

  describe "#get_encrypted_payload" do
    subject(:encrypted_payload) { data_processor.get_encrypted_payload(user_double) }
    let(:decrypted_payload) { "#{user_double.user_name}#{data_delimiter}"}

    it "returns encrypted payload" do
      expect(encrypted_payload).not_to include decrypted_payload
    end
  end

  describe "#get_user_params" do
    subject(:user_params) { data_processor.get_user_params(encrypted_payload) }
    let(:encrypted_payload) { "+6HBhsLPZeMHGNMhEKu1B3pZ01y3MSXPrLcvE0rmDsZ7UZfnZ9QvtZEzy2CX--BEgYeE7g3GCXDAX9--BWHVGFcwMO0G0WB6Qfyy/A==" }
    let(:expected_timestamp) { "2021-10-13 17:36:12 UTC" }

    it "returns user params that contains user_name" do
      expect(user_params[:user_name]).to eq(user_double.user_name)
    end

    it "returns user params created_at timestamp correct value" do
      expect(user_params[:created_at]).to eq(expected_timestamp)
    end
  end

  describe "#payload_valid?" do
    context "when given valid payload" do
      subject(:payload_valid?) {data_processor.payload_valid?(encrypted_payload)}
      let(:encrypted_payload) {"+6HBhsLPZeMHGNMhEKu1B3pZ01y3MSXPrLcvE0rmDsZ7UZfnZ9QvtZEzy2CX--BEgYeE7g3GCXDAX9--BWHVGFcwMO0G0WB6Qfyy/A=="}

      it "returns true" do
        expect(payload_valid?).to eq true
      end
    end

    context "when invalid payload given" do
      subject(:payload_valid?) {data_processor.payload_valid?(incorrect_payload)}
      let(:incorrect_payload) {"incorrect:payload"}

      it "returns false" do
        expect(payload_valid?).to eq false
      end
    end
  end

end