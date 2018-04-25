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

  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end
end
