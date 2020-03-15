class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_type, :string
    add_column :posts, :photo, :string
  end
end
