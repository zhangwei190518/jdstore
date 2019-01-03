require "rails_helper"

RSpec.describe "Registrations", type: :request do

  request_helper

  let(:user) { create(:user) }

  let(:valid_signup_params) {
    {
      email: Faker::Internet.safe_email,
      mobile: Faker::PhoneNumber.cell_phone,
      password: "123456",
      password_confirmation: "123456",
    }
  }

  # @TODO params_with_token 和 signed_get 待优化
  describe "POST /api/v1/users/signup" do
    context "invalid" do
      it "with different password" do
        invalid_signup_params = params_with_token[:params].merge(user: valid_signup_params.merge(password: "different password"))
        post "/api/v1/users", params: invalid_signup_params

        result = JSON.parse(response.body)
        expect(result["message"]).to eq ["确认密码 与密码不一致"]
      end

      it "with invalid email" do
        invalid_signup_params = params_with_token[:params].merge(user: valid_signup_params.merge(email: "invalid email"))
        post "/api/v1/users", params: invalid_signup_params

        result = JSON.parse(response.body)
        expect(result["message"]).to eq ["邮箱 格式无效"]
      end
    end

    context "with valid params" do
      it "with right data stucture" do
        post "/api/v1/users", params: params_with_token[:params].merge(user: valid_signup_params)

        result = JSON.parse(response.body)
        user = User.first
        expect(result["id"]).to eq user.id
        expect(result["email"]).to eq user.email
        expect(result["mobile"]).to eq user.mobile
        expect(result["authentication_token"]).to eq user.authentication_token
        expect(result["is_admin"]).to eq user.is_admin
      end
    end
  end

end
