class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post

  has_many :friendships, dependent: :destroy #, class_name: "friendship", primary_key: "id", foreign_key: "user_id"
  has_many :friends, through: :friendships #, source: :friend

  has_many :inverse_friends, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friendlys, through: :inverse_friends, source: :user

  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def friendlys?(user)
    self.friendlys.include?(user)
  end

  def all_friends
    friends = (self.friends + self.friendlys).uniq
  end

  def friended
    
  end
end
