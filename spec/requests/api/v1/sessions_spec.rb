require "rails_helper"

RSpec.describe "Sessions", type: :request do

  request_helper

  let(:user) { create(:user) }

  let(:valid_signin_params) {
    {
      email: user.email,
      password: user.password,
    }
  }

  describe "POST /api/v1/users/sign_in" do
    context "invalid" do
      it "with blank email and password" do
        post "/api/v1/users/sign_in", params_with_token

        result = JSON.parse(response.body)
        expect(result["message"]).to eq "邮箱或者密码错误"
      end

      it "with wrong password" do
        invalid_signin_params = params_with_token[:params].merge(valid_signin_params.merge(password: "wrong password"))
        post "/api/v1/users/sign_in", params: invalid_signin_params

        result = JSON.parse(response.body)
        expect(result["message"]).to eq "邮箱或者密码错误"
      end

      it 'with wrong email' do
        invalid_signin_params = params_with_token[:params].merge(valid_signin_params.merge(email: "wrong email"))
        post "/api/v1/users/sign_in", params: invalid_signin_params

        result = JSON.parse(response.body)
        expect(result["message"]).to eq "邮箱或者密码错误"
      end
    end

    context "with valid params" do
      it "with right data stucture" do
        post "/api/v1/users/sign_in", params: params_with_token[:params].merge(valid_signin_params)

        result = JSON.parse(response.body)
        expect(result["id"]).to eq user.id
      end
    end
  end

  it "POST /api/v1/users/sign_out" do
    original_authentication_token = user.authentication_token

    delete "/api/v1/users/sign_out", signed_get

    user.reload
    expect(user.authentication_token).not_to eq original_authentication_token
  end

end
