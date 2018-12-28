class Api::V1::ProductsController < ::ProductsController

  def index
    super
  end

  def show
    super
  end

  def search
    super

    render json: { success: false, message: t("response_message.not_found") }, status: :not_found and return if @products.blank?

    render "api/v1/products/index"
  end
end
