require "rails_helper"

RSpec.describe Api::V1::Account::OrdersController, type: :routing do

  describe "routing" do
    it "routes to #index" do
      expect(:get => "api/v1/account/orders").to route_to("api/v1/account/orders#index", format: :json)
    end
  end

end