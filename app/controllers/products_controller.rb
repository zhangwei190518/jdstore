class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).selling

    if params[:category_name].present?
      category = Category.find_by(name: params[:category_name])
      @products = @products.where(category: category)
    end

    @products = @products.paginate(page: params[:page], per_page: per_page)
  end

  def show
    @product = Product.find(params[:id])
    @pictures = @product.pictures.asc
    @comments = @product.comments.includes(:user).recent
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "成功加入购物车"
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
    redirect_to :back
  end

  def search
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?

    @products = Product.selling.ransack({title_cont: @query_string}).result(distinct: true).paginate(page: params[:page], per_page: per_page)
  end

  private

  def per_page
    params[:per_page] || 8
  end
end
