class RemoveInlineImagesFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :inline_images
  end

  def down
    add_column :posts, :inline_images, :boolean
  end
end
