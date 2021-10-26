require './app/services/encryptor.rb'
require "spec_helper"

RSpec.describe Encryptor, type: :service do
  subject(:encryptor) { Encryptor.new(specific_key) }
  let(:specific_key) { Rails.application.credentials.test[:test_key] }
  let(:test_string_decrypted) { 'TestValue' }
  let(:test_string_encrypted) { 'B2yt2pEcb0fIVafUM1/v1gF24g==--qWi4d24l+aQN01Cw--mrRtz3Nk1joVFTYJ6C1qwQ==' }

  describe '#encrypt' do
    subject(:encrypted_string) { encryptor.encrypt(test_string_decrypted) }

    it 'encrypts data' do
      expect(encrypted_string).not_to eq(test_string_decrypted)
    end
  end

  describe '#decrypt' do
    subject(:decrypt) { encryptor.decrypt(test_string_encrypted) }

    it 'decrypts data properly' do
      expect(decrypt).to eq(test_string_decrypted)
    end
  end

  describe 'raising errors' do
    context 'with specified invalid encryption key' do
      subject(:encryptor) { Encryptor.new(invalid_key) }
      let(:invalid_key) { 'some_defiitely_wrong key' }

      describe '#encrypt' do
        subject(:encrypt) { encryptor.encrypt(test_string_decrypted) }

        it 'raises an exception' do
          # expect(encrypt).to raise_error(OpenSSL::Cipher::CipherError)
          expect{ encrypt }.to raise_error(OpenSSL::Cipher::CipherError)
        end
      end

      describe '#encrypt' do
        subject(:decrypt) { encryptor.decrypt(test_string_encrypted) }

        it 'raises an exception' do
          expect{ decrypt }.to raise_error(ActiveSupport::MessageEncryptor::InvalidMessage)
        end
      end
    end
  end
end