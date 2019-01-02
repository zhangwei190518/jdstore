require "rails_helper"

RSpec.describe Api::V1::Account::OrdersController, type: :controller do

  before(:each) do
    controller.class.skip_before_action :access_token_auth, raise: false
  end

  login_user

  describe "GET #index" do
    it "not login" do
      sign_out user

      get :index

      expect(response).to have_http_status(401)
    end

    context "login" do
      it "without any order" do
        get :index

        expect(response).to have_http_status(404)
      end

      it "with orders" do
        create(:public_order, user: user)

        get :index

        expect(response).to have_http_status(200)
      end
    end
  end

end
