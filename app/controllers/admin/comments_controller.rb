class Admin::CommentsController < AdminController

  before_action :find_comment, only: [:publish, :hide]

  def index
    @comments = Comment.includes(:user, :product).recent
  end

  def publish
    @comment.publish!
    redirect_back(fallback_location: root_path)
  end

  def hide
    @comment.hide!
    redirect_back(fallback_location: root_path)
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
