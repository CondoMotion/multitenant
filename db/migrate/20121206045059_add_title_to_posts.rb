class AddTitleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    remove_column :posts, :content
  end
end
