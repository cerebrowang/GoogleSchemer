class Comment < ActiveRecord::Base
  belongs_to :scheme
  has_many :replies, :dependent => :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope { order('comments.created_at DESC') }
end
