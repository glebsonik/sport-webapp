require 'openssl'
module SessionsHelper

  def get_user_token(user_id)
    key = Rails.application.credentials.secret_token_key
    crypt = ActiveSupport::MessageEncryptor.new(key)
    crypt.encrypt_and_sign(user_id.to_s)
  end

  def get_user_id(user_token)
    key = Rails.application.credentials.secret_token_key
    crypt = ActiveSupport::MessageEncryptor.new(key)
    crypt.decrypt_and_verify(user_token)
  end

end
