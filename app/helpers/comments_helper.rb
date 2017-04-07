module CommentsHelper
  def commenter
  	@commenter = User.where(id: @comment.user_id).first
  end
end
