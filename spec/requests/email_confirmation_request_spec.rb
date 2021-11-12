require 'rails_helper'

RSpec.describe EmailConfirmationController, type: :request do

  describe "GET /index" do
    context "when no payload given" do
      before do
        get "/email_confirmation/show"
      end

      it "redirects to root redirects if no payload" do
        expect(response).to redirect_to '/'
      end
    end

    context "when incorrect payload given" do
      before do
        get "/email_confirmation/show?payload=invalid_payload_value"
      end

      it "redirects to root if invalid payload" do
        expect(response).to redirect_to '/'
      end
    end
  end

end
