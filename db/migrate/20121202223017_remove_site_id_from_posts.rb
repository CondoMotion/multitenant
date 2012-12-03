class RemoveSiteIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :site_id
    add_column :posts, :page_id, :integer
    add_index :posts, :page_id
  end
end
