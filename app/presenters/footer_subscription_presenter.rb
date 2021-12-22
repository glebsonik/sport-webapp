class FooterSubscriptionPresenter
  def initialize(params)
    @params = params
  end

  def subscription_params
    if @params[:team]
      {
        subscription_type: :team,
        name: @params[:team]
      }
    elsif @params[:conference]
      {
        subscription_type: :conference,
        name: @params[:conference]
      }
    else
      {
        subscription_type: :category,
        name: @params[:category]
      }
    end
  end
end