class Api::V1::Account::OrdersController < ::Account::OrdersController

  before_action :authenticate_user!

  def index
    super

    render json: { success: false, message: t("response_message.not_found") }, status: :not_found if @orders.blank?
  end

end
