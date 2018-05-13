class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  mount_uploader :image, PhotoUploader

  validates_presence_of :title, :authorized

    
  def is_collected?(user)
    self.collected_users.include?(user)
  end

  def self.readable_by(user)
    Post.where(authorized: "friends", user: user.all_friends).or(Post.where(authorized: "all")).or(Post.where(user: user))  
  end

  def readable_by(user)
    Post.readable_by(user).include?(self)
  end

  def count_view
    self.views_count += 1
    self.save
  end
  
end
