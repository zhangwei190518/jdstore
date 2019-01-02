module RequestMacros

  def request_helper
    let(:user) { create(:user) }
    let(:headers_with_token) { { "X-User-Email": user.email, "X-User-Token": user.authentication_token } }
    let(:access_token) {
      post api_v1_access_token_path, params: { app_id: JDSTORE_KEYS[:access_token][:app_id], app_key: JDSTORE_KEYS[:access_token][:app_key] }
      result = JSON.parse(response.body)
      { token: result["access_token"] }
    }
  end

end
