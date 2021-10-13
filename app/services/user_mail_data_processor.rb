class UserMailDataProcessor

  DEFAULT_DATA_DELIMITER = ';;;'

  def initialize(delimiter = DEFAULT_DATA_DELIMITER)
    @encryptor = Encryptor.new(Rails.application.credentials.mail_token_key)
    @delimiter = delimiter
  end

  def get_encrypted_payload(user)
    sent_at = Time.zone.now
    decrypted_payload = "#{user.user_name}#{@delimiter}#{sent_at.to_s}"
    @encryptor.encrypt(decrypted_payload)
  end

  def get_user_params(encrypted_payload)
    payload = @encryptor.decrypt(encrypted_payload)

    user_name, created_at = payload.split(@delimiter)

    {user_name: user_name, created_at: created_at}
  end

  def payload_valid?(encrypted_payload)
    begin
      payload = @encryptor.decrypt(encrypted_payload)
      payload_valid = payload.index(@delimiter).present?
    rescue Exception
      payload_valid = false
    end
    payload_valid
  end
end