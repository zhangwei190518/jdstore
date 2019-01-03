class Api::V1::SessionsController < Devise::SessionsController

  skip_before_action :verify_authenticity_token
  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    user = User.find_for_database_authentication(email: params[:email]) if params[:email] && params[:password]

    if user && user.valid_password?(params[:password])
      sign_in(:user, user)
      render partial: "api/v1/users/user", locals: { user: user }
    else
      invalid_login_attempt
    end
  end

  def destroy
    if current_user
      current_user.update(authentication_token: nil)
      sign_out(resource_name)

      render json: { message: "Ok", success: true }, status: :ok
    end
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render json: { message: t("response_message.wrong_login_params"), success: false }, status: :unauthorized
  end

end
