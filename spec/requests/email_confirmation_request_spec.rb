require 'rails_helper'

RSpec.describe "EmailConfirmations", type: :request do

  describe "GET /show" do
    it "redirects to root redirects if no payload" do
      get "/email_confirmation/show"
      expect(response).to redirect_to '/'
    end

    it "redirects to root if invalid payload" do
      get "/email_confirmation/show?payload=invalid_payload_value"
      expect(response).to redirect_to '/'
    end
  end

end
