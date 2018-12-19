class ProductsController < ApplicationController
  def index
    @products = Product.selling
  end

  def show
    @product = Product.find(params[:id])
  end
end
