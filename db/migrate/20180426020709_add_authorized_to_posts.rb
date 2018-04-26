class AddAuthorizedToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :authorized, :string
  end
end
