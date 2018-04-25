class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  mount_uploader :image, PhotoUploader

  validates_presence_of :title

    
  def is_collected?(user)
    self.collected_users.include?(user)
  end

  
end
