require 'rails_helper'

RSpec.describe "EmailConfirmations", type: :request do

  describe "GET /show" do
    it "returns redirects if no payload" do
      get "/email_confirmation/show"
      expect(response).to have_http_status(:redirect)
    end

    it "returns redirects if invalid payload" do
      invalid_payload = {payload: "invalid_payload_value"}
      get "/email_confirmation/show?#{invalid_payload.to_query}"
      expect(response).to have_http_status(:redirect)
    end
  end

end
