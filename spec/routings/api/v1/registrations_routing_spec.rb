require "rails_helper"

RSpec.describe Api::V1::RegistrationsController, type: :routing do

  describe "routing" do
    it "routes to #create" do
      expect(post: "api/v1/users").to route_to("api/v1/registrations#create", format: :json)
    end
  end

end