class ApplicationController < ActionController::Base
  include SecurityToken

  acts_as_token_authentication_handler_for User, fallback: :none, if: lambda { |controller| controller.request.format.json? }

  before_action :find_categories
  before_action :access_token_auth
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "你不是商家用户，没有权限访问该地址。"
    end
  end

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end

  def find_categories
    @categories = Category.all
  end
end
