module RepliesHelper
  def replier(id)
  	replier = User.where(id: id).first
  end

   def reply_count(comment)
    if comment.replies.count > 0 
      comment.replies.count.to_s + ' replies'
    else
      'Reply'
    end
  end
   
end
