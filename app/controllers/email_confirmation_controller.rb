EMAIL_LINK_EXPIRATION = 5.days
class EmailConfirmationController < ApplicationController

  before_action :validate_payload, only: :show

  def show
    user_params = get_user_params

    user = User.find_by(user_name: user_params[:user_name])
    if link_not_expired?(user_params[:created_at]) && user.present?
      user.status = 'active'
      unless user.save
        flash.now[:alert] = "Something went wrong. Please try again or re-request email confirmation"
        render :show
      end
    else
      flash.now[:alert] = "Something went wrong. Please try again or re-request email confirmation"
      render :show
    end
    # user = User.find(user_params[:user_name])
    #
    # return user.update!(status: :active) if link_not_expired?(user_params[:created_at]) && user.present?
    #
    # flash.now[:alert] = "Something went wrong. Please try again or re-request email confirmation"
    # render :index
  end

  def preconfirmation
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
    (Time.parse(creation_time) + EMAIL_LINK_EXPIRATION) > Time.zone.now
  end
end
