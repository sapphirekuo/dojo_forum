class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :description
      t.string :image
      t.string :status
      t.integer :user_id
      t.integer :category_id
      t.integer :replies_count
      t.integer :views_count
      t.integer :likes_count

      t.timestamps
    end
  end
end
