class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "你不是商家用户，没有权限访问该地址。"
    end
  end
end
