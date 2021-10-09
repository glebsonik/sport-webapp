require 'rails_helper'

RSpec.describe "AdminHomes", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin_home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
