class RenameLikesCountInPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :likes_count, :collects_count
    rename_column :users, :likes_count, :collects_count
  end
end
