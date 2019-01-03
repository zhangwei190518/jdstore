module Admin::CommentsHelper
  def render_comment_hidden_state(comment)
    if comment.is_hidden?
      "已隐藏"
    else
      "已展示"
    end
  end

  def render_hidden_btn(comment)
    if comment.is_hidden?
      link_to("展示", publish_admin_comment_path(comment), method: :put, class: "btn btn-xs btn-primary")
    else
      link_to("隐藏", hide_admin_comment_path(comment), method: :put, class: "btn btn-xs btn-primary")
    end
  end
end