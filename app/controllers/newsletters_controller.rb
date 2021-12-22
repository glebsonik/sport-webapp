class NewslettersController < ApplicationController
  def subscribe
    @subscription = NewsletterSubscription.new(email: params[:email],
                                               subscription_type: params[:subscription_type],
                                               name: params[:name])

    if @subscription.save
      redirect_to root_url, notice: 'You have successfully subscribed for the newsletter!'
    else
      redirect_to root_url, alert: "An error occurred during subscription: #{@subscription.errors.full_messages.join(', ')}"
    end
  end
end
