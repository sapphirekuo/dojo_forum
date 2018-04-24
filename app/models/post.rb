class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :replies, dependent: :destroy

  mount_uploader :image, PhotoUploader

  
end
