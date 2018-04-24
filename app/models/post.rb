class Post < ApplicationRecord
  belongs_to :category, optional: true

  mount_uploader :image, PhotoUploader

  
end
