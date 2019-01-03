class Admin::ProductsController < AdminController

  def index
    @products = Product.all.paginate(page: params[:page], per_page: per_page)
  end

  def new
    @product = Product.new
    @picture = @product.pictures.build #商品详情增加多张图片功能相关
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    # 更新商品详情区域多张图片的判断
    if params[:pictures].present?
      params[:pictures]['avatar'].each do |a|
        @product.pictures.create(:avatar => a)
      end
    end

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      if params[:pictures].present?
        params[:pictures]['avatar'].each do |a|
          @product.pictures.create(:avatar => a)
        end
      end

      redirect_to admin_products_path
    else
      render :new
    end
  end

  def search
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @products = Product.ransack({title_cont: @query_string}).result(distinct: true).paginate(page: params[:page], per_page: per_page)

    render :index
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :is_hidden, :pictures)
  end

  def per_page
    params[:per_page] || 10
  end
end
