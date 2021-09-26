class EmailConfirmationController < ApplicationController

  before_action :validate_payload, only: :index

  def index
    user_params = get_user_params

    user = User.find_by(user_name: user_params[:user_name])
    if link_not_expired?(user_params[:created_at]) && user
      user.status = 'active'
      unless user.save
        flash.now[:alert] = "Something went wrong. Please try again or re-request email confirmation"
        render :index
      end
    else
      flash.now[:alert] = "Something went wrong. Please try again or re-request email confirmation"
      render :index
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
    payload_valid = UserMailDataProcessor.new.payload_valid?(params[:payload])
    redirect_to root_url, alert: "Error while processing email data" unless payload_valid
  end

  def get_user_params
    UserMailDataProcessor.new.get_user_params(params[:payload])
  end

  def link_not_expired?(creation_time)
    (Time.parse(creation_time) + 5.days) > Time.zone.now
  end
end
