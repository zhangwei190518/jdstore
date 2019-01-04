require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    controller.class.skip_before_action :access_token_auth, raise: false
  end

  let(:user) { create(:user) }

  let(:valid_signin_params) {
    {
      email: user.email,
      password: user.password,
    }
  }

  describe "POST #create" do
    it "with valid params" do
      post :create, params: valid_signin_params

      expect(response).to have_http_status(200)
    end

    context "invalid" do
      it "with blank email and password" do
        post :create

        expect(response).to have_http_status(401)
      end

      it "with wrong password" do
        invalid_signup_params = valid_signin_params.merge(password: "wrong password")
        post :create, params: invalid_signup_params

        expect(response).to have_http_status(401)
      end

      it 'with wrong email' do
        invalid_signup_params = valid_signin_params.merge(email: "wrong email")
        post :create, params: invalid_signup_params

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE #destroy" do
    login_user

    it "login" do
      delete :destroy

      expect(response).to have_http_status(204)
    end

    it "not login" do
      sign_out user
      delete :destroy

      expect(response).to have_http_status(204)
    end
  end

end
