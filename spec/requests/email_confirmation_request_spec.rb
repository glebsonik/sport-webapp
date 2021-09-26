require 'rails_helper'

RSpec.describe "EmailConfirmations", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/email_confirmation/index"
      expect(response).to have_http_status(:success)
    end
  end

end
