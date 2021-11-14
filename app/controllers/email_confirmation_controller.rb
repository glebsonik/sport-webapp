class EmailConfirmationController < ApplicationController
  EMAIL_LINK_EXPIRATION = 5.days

  before_action :validate_payload, only: :show

  def show
    user_params = get_user_params

    user = User.find_by(user_name: user_params[:user_name])

    if link_not_expired?(user_params[:created_at]) && user.present? && user.update(status: :active)
      redirect_to root_url, notice: t('email.successful_notice')
    else
      flash.now[:alert] = t('email.email_confirmation_alert')
      render :show
    end
  end

  def preconfirmation
  end

  def resend_email
    UserMailer.with(user: current_user).confirmation_email.deliver_later
    redirect_to root_url, notice: t('email.sent_email_message')
  end

  private

  def validate_payload
    payload_valid = UserMailDataProcessor.new.payload_valid?(params[:payload])
    redirect_to root_url, alert: t('email.email_validation_error') unless payload_valid
  end

  def get_user_params
    UserMailDataProcessor.new.get_user_params(params[:payload])
  end

  def link_not_expired?(creation_time)
    (Time.parse(creation_time) + EMAIL_LINK_EXPIRATION) > Time.zone.now
  end
end