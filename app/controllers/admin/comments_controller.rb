class Admin::CommentsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_comment, only: [:publish, :hide]

  def index
    @comments = Comment.includes(:user, :product).recent
  end

  def publish
    @comment.publish!
    redirect_to :back
  end

  def hide
    @comment.hide!
    redirect_to :back
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
