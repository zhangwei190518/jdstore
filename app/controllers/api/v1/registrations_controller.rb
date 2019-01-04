class Api::V1::RegistrationsController < Devise::RegistrationsController

  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)

    if user.save
      render partial: "api/v1/users/user", locals: { user: user }
    else
      render json: { message: user.errors.full_messages, success: false }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :mobile)
  end
end
