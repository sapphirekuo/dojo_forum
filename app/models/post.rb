class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user

  mount_uploader :image, PhotoUploader

  
end
