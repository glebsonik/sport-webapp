class UserMailDataProcessor

  def initialize
    @encryptor = Encryptor.new(Rails.application.credentials.mail_token_key)
    @delimiter = ';;;'
  end

  def get_encrypted_payload(user)
    sent_at = Time.zone.now
    decrypted_payload = "#{user.user_name}#{@delimiter}#{sent_at}"
    @encryptor.encrypt(decrypted_payload)
  end

  def get_user_params(encrypted_payload)
    payload = @encryptor.decrypt(encrypted_payload)

    delimiter_index = payload.rindex(@delimiter)
    user_name = payload[0..delimiter_index-1]
    created_at = payload[delimiter_index+1..-1]
    {user_name: user_name, created_at: created_at}
  end

  def payload_valid?(encrypted_payload)
    begin
      payload = @encryptor.decrypt(encrypted_payload)
      payload_valid = payload.rindex(@delimiter).present?
    rescue Exception
      payload_valid = false
    end
    payload_valid
  end
end