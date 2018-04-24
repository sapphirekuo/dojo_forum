class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :replies, dependent: :destroy

  mount_uploader :image, PhotoUploader

  validates_presence_of :title

  
end
