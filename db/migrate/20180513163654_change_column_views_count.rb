class ChangeColumnViewsCount < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :views_count, :integer, default: 0
    change_column :posts, :replies_count, :integer, default: 0
    change_column :users, :replies_count, :integer, default: 0
    change_column :users, :collects_count, :integer, default: 0
    change_column :users, :friends_count, :integer, default: 0
    change_column :users, :inverse_friends_count, :integer, default: 0
  end
end
