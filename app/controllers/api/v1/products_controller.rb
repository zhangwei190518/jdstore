class Api::V1::ProductsController < ::ProductsController

  def index
    super
  end

  def show
    super
  end

  def search
    render json: { success: false, message: t("response_message.params_missing") }, status: :unprocessable_entity and return if params[:q].blank?

    super

    render json: { success: false, message: t("response_message.not_found") }, status: :not_found and return if @products.blank?

    render "api/v1/products/index"
  end
end
