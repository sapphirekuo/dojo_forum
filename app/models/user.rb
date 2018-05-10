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

  before_create :generate_authentication_token

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

  def admin?
    self.role == "admin"
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def friendly?(user)
    self.friendlys.include?(user)
  end

  def all_friends
    friends = (self.friends + self.friendlys).uniq
  end

  def friended
    friends = (self.friends + self.friendlys)

    friended = friends.select{|item| friends.count(item) > 1}.uniq
  end


  def friend_waiting
    friend_waiting = self.friends - self.friended    
  end

  def friendly_to_accept
    friendly_to_accept = self.friendlys - self.friended
  end
end
