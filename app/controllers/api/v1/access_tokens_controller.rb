class Api::V1::AccessTokensController < ApplicationController

  skip_before_action :verify_authenticity_token, :access_token_auth, only: [:show]

  def show
    if params[:app_id] == JDSTORE_KEYS[:access_token][:app_id] && params[:app_key] == JDSTORE_KEYS[:access_token][:app_key]
      ct = current_token

      render json: {
        success: true,
        access_token: ct[:access_token],
        expire_in: ct[:expired_at].to_i - Time.now.to_i
      }
    else
      render status: :unauthorized
    end
  end

end
