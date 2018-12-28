class Api::V1::ProductsController < ::ProductsController

  def index
    super
  end

  def show
    super
  end

  def search
    super

    render "api/v1/products/index"
  end
end
