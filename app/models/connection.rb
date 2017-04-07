class Connection < ActiveRecord::Base
  belongs_to :schemer, class_name: "User"
  belongs_to :scheme, class_name: "Scheme"

  validates :schemer_id, presence: true
  validates :scheme_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"

    where("schemer_id IN (#{followed_user_ids}) OR schemer_id = :user_id", 
          user_id: user.id).order('created_at DESC')
  end
end
