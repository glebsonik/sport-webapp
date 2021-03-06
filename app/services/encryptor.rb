class Encryptor

  def initialize(key = Rails.application.credentials.secret_token_key)
    @encryptor = ActiveSupport::MessageEncryptor.new(key)
  end

  def encrypt(data)
    @encryptor.encrypt_and_sign(data.to_s)
  end

  def decrypt(encrypted_data)
    @encryptor.decrypt_and_verify(encrypted_data)
  end

end