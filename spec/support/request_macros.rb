module RequestMacros

  require Rails.root.join("config/jdstore_contant.rb")

  def request_helper
    let(:user) { create(:user) }
    let(:headers_with_token) { { "X-User-Email": user.email, "X-User-Token": user.authentication_token } }
    let(:access_token) {
      get api_v1_access_token_path, params: { app_id: JDSTORE_KEYS[:access_token][:app_id], app_key: JDSTORE_KEYS[:access_token][:app_key] }
      result = JSON.parse(response.body)
      { token: result["access_token"] }
    }

    let(:signed_get) {
      {
        params: { token: access_token[:token] },
        headers: headers_with_token,
      }
    }

    let(:params_with_token) {
      {
        params: { token: access_token[:token] },
      }
    }
  end

end
