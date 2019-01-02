module SecurityToken
  extend ActiveSupport::Concern

  protected

  def access_token_auth
    token = params[:token] || request.headers["X-Access-Token"]

    render json: { message: "Token required", success: false }, status: :forbidden if !token_effect?(token)
  end

  # @TODO 实现自动更换，暂时使用固定值模拟
  def current_token
    { access_token: "TEST-ACCESS-TOKEN", expired_at: Time.now + 7.days }
  end

  def token_effect?(token)
    ct = current_token
    Time.now.to_i < ct[:expired_at].to_i && token == current_token[:access_token]
  end

  # @TODO 实现Token生成
  def generate_access_token
    current_token
  end

end