require "rails_helper"

RSpec.describe "Orders", type: :request do

  request_helper

  describe "GET /api/v1/account/orders" do
    context "auth" do
      it "without user_token" do
        get "/api/v1/account/orders", params: { token: access_token[:token] }

        result = JSON.parse(response.body)
        expect(result["error"]).to eq "继续操作前请注册或者登录。"
      end

      it "with wrong user_token" do
        get "/api/v1/account/orders", params: { token: access_token[:token] }, headers: { "X-User-Email": user.email, "X-User-Token": "wrong_user_authentication_token" }

        result = JSON.parse(response.body)
        expect(result["error"]).to eq "继续操作前请注册或者登录。"
      end

      it "with right user_token" do
        get "/api/v1/account/orders", params: { token: access_token[:token] }, headers: headers_with_token

        result = JSON.parse(response.body)
        expect(result["error"]).to be_nil
      end
    end

    it "without any order" do
      get "/api/v1/account/orders", params: { token: access_token[:token] }, headers: headers_with_token

      result = JSON.parse(response.body)
      expect(result["message"]).to eq "记录不存在"
    end

    it "right count" do
      user_orders = create_list(:public_order, 3, user: user)
      create_list(:public_order, 2)

      get "/api/v1/account/orders", params: { token: access_token[:token] }, headers: headers_with_token

      result = JSON.parse(response.body)
      expect(result["orders"].size).to eq user_orders.size
    end

    it "with right data structure" do
      order = create(:public_order, user: user)

      get "/api/v1/account/orders", params: { token: access_token[:token] }, headers: headers_with_token

      result = JSON.parse(response.body)["orders"].first
      expect(result["id"]).to eq order.id
      expect(result["billing_name"]).to eq order.billing_name
      expect(result["billing_address"]).to eq order.billing_address
      expect(result["shipping_name"]).to eq order.shipping_name
      expect(result["shipping_address"]).to eq order.shipping_address
      expect(result["is_paid"]).to eq order.is_paid
      expect(result["aasm_state"]).to eq order.aasm_state
    end
  end
end
