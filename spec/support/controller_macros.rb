module ControllerMacros

  def login_user(type: :user)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(type)
      sign_in user
    end

    let(:user) {
      login_info = session["warden.user.user.key"]
      User.find(login_info[0].first)
    }
  end

end
