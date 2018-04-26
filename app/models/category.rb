class Category < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error
  validates_presence_of :name
  validates_uniqueness_of :name
end
