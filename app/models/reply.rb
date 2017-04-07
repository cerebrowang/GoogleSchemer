class Reply < ActiveRecord::Base
  belongs_to :comment

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope { order('replies.created_at DESC') }
end
