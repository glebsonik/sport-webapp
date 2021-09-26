class UserMailer < ApplicationMailer

  def confirmation_email
    @user = params[:user]
    @url  = confirmation_url(@user)
    @timestamp = params[:timestamp]
    mail(to: @user.email, subject: 'Welcome to SportsHub!')
  end

  private

  def confirmation_url(user)
    payload = { payload: UserMailDataProcessor.new.get_encrypted_payload(user) }
    "#{confirm_email_url}?#{payload.to_query}"
  end

end
