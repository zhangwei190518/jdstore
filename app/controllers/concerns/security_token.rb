module SecurityToken
  extend ActiveSupport::Concern

  protected

  def access_token_auth
    token = params[:token] || request.headers["X-Access-Token"]

    render json: { message: "Token required", success: false }, status: :forbidden if !token_effect?(token)
  end

  def current_token
    key = "jdstore_access_token"
    token = Rails.cache.read(key)

    if token.nil? || token[:expired_at].to_i < Time.now.to_i
      expire_in = [7,10,14].sample.days
      token = { access_token: SecureRandom.hex(10), expired_at: Time.now + expire_in }
      Rails.cache.write(key, token, expires_in: expire_in)
    end

    return token
  end

  def token_effect?(token)
    ct = current_token
    Time.now.to_i < ct[:expired_at].to_i && token == ct[:access_token]
  end

end