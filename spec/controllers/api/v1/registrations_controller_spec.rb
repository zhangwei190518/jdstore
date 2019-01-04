require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    controller.class.skip_before_action :access_token_auth, raise: false
  end

  let(:valid_signup_params) {
    {
      email: Faker::Internet.safe_email,
      mobile: Faker::PhoneNumber.cell_phone,
      password: "123456",
      password_confirmation: "123456",
    }
  }

  describe "POST #create" do
    it "with valid params" do
      post :create, params: { user: valid_signup_params }

      expect(response).to have_http_status(200)
    end

    context "invalid" do
      it "with different password" do
        invalid_signup_params = valid_signup_params.merge(password: "different password")
        post :create, params: { user: invalid_signup_params }

        expect(response).to have_http_status(400)
      end

      it 'with invalid email' do
        invalid_signup_params = valid_signup_params.merge(email: "invalid email")
        post :create, params: { user: invalid_signup_params }

        expect(response).to have_http_status(400)
      end
    end
  end

end
