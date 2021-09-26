class UserMailer < ApplicationMailer

  def confirmation_email
    @user = params[:user]
    @url  = confirmation_url
    @timestamp = params[:timestamp]
    mail(to: @user.email, subject: 'Welcome to SportsHub!')
  end

  private

  def confirmation_url
    payload = { payload: mail_payload }
    "#{confirm_email_url}?#{payload.to_query}"
  end

  def mail_payload
    sent_at = Time.zone.now
    decrypted_payload = "#{@user.user_name}:#{sent_at}"

    Encryptor.new(Rails.application.credentials.mail_token_key).encrypt(decrypted_payload)
  end

end
