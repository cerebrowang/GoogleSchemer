class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #TODO
  devise :invitable, :database_authenticatable, :registerable , #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:github, :google_oauth2]

  mount_uploader :image, AvatarUploader

  extend OmniauthCallbacks
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :connections, foreign_key: "schemer_id", dependent: :destroy
  has_many :schemes, through: :connections, source: :scheme
  has_many :locations
  has_many :authorizations, :dependent => :destroy

  before_save { |user| user.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #validates :password, presence: true, length: {minimum: 8, maximum: 120}, on: :create
  #validates :password, length: {minimum: 8, maximum: 120}, on: :update, allow_blank: true

  def bind_service(response)                                                    
    provider = response["provider"]                                             
    uid = response["uid"]                                                       
    authorizations.create(:provider => provider , :uid => uid )                 
  end

  def feed
    Scheme.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.where(followed_id: other_user.id).first
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.where(followed_id: other_user.id).first.destroy
  end

  def do!(scheme)
    connection = connections.where(scheme_id: scheme.id).first
    if connection.nil?
      connections.create!(scheme_id: scheme.id, is_done: false)
    else
      connection.update_attributes!(:is_done => false)
    end
  end

  def done!(scheme)
    connection = connections.where(scheme_id: scheme.id).first
    if connection.nil?
      connections.create!(scheme_id: scheme.id, is_done: true)
    else
      connection.update_attributes!(:is_done => true)
    end
  end

  def as_json(opts={})
    {
      :id => self.id,
      :item_string => self.name,
      :class_name => self.class.name
    }
  end
end
