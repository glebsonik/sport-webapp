require './app/services/encryptor.rb'
require "spec_helper"

RSpec.describe Encryptor, type: :service do

  describe " #encrypt and #decrypt" do

    context "when using default key" do
      it "encrypts and decrypts data" do
          encryptor = Encryptor.new
          test_string_to_encrypt = "Test value!"

          encrypted_string = encryptor.encrypt(test_string_to_encrypt)
          decrypted_string = encryptor.decrypt(encrypted_string)

          expect(decrypted_string).to eq(test_string_to_encrypt)
        end
    end

    context "when using outer key" do
      it "encrypts and decrypts data" do
        encryptor = Encryptor.new(Rails.application.credentials.test[:test_key])
        test_string_to_encrypt = "Test value!"

        encrypted_string = encryptor.encrypt(test_string_to_encrypt)
        decrypted_string = encryptor.decrypt(encrypted_string)

        expect(decrypted_string).to eq(test_string_to_encrypt)
      end
    end
  end

  describe "Raising exceptions" do

    context "when given incorrect key" do
      it "raises an exception" do
        encryptor = Encryptor.new('some_defiitely_wrong key')
        test_string_to_encrypt = "Will not encrypt"

        expect {encryptor.encrypt(test_string_to_encrypt)}.to raise_error
      end
    end

  end

end