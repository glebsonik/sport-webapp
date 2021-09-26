class EmailConfirmationController < ApplicationController

  before_action :validate_payload, only: :index

  def index
    user_data = Encryptor.new(Rails.application.credentials.mail_token_key).decrypt(params[:payload])
    user_params = parse_user_params(user_data)

    user = User.find_by(user_name: user_params[:user_name])
    if link_not_expired?(user_params[:created_at]) && user
      user.status = 'active'

      unless user.save
        render :index, alert: "Something went wrong. Please try again or re-request email confirmation"
      end
    else
      render :index, alert: "Link has expired or link has invalid user_name. Please re-request email"
    end
  end

  def resend_preview
  end

  def resend_email
    UserMailer.with(user: current_user).confirmation_email.deliver_later
    redirect_to root_url, notice: "Email sent successfully"
  end

  private

  def validate_payload
    begin
      payload = Encryptor.new(Rails.application.credentials.mail_token_key).decrypt(params[:payload])
      payload_valid = payload.rindex(':').nil?
    rescue Exception
      payload_valid = false
    end
    redirect_to root_url, alert: "Error while processing email data" unless payload_valid
  end

  def parse_user_params(user_data)
    delimiter_index = user_data.rindex(':')
    created_at = user_data[delimiter_index+1..-1]
    user_name = user_data[0..delimiter_index-1]
    {created_at: created_at, user_name: user_name}
  end

  def link_not_expired?(creation_time)
    Time.parse(creation_time) + 5.days < Time.zone.now
  end
end
