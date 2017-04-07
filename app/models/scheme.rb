class Scheme < ActiveRecord::Base
  mount_uploader :image, CoverUploader

  # Alias for <tt>acts_as_ordered_taggable_on :tags</tt>:
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :tag_list

  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :reverse_connections, foreign_key: "scheme_id",
                                   class_name:  "Connection",
                                   dependent:   :destroy
  has_many :schemers, through: :reverse_connections, source: :schemer

  has_many :locations

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope { order('schemes.created_at DESC') }

  def rank
    self.schemers.count
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def as_json(opts={})
    {
      :id => self.id,
      :item_string => self.content,
      :class_name => self.class.name
    }
  end
end
