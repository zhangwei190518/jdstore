class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_product

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.product = @product
    @comment.user = current_user

    if @comment.save
      redirect_to product_path(@product), notice: '成功发表评论'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end
end
