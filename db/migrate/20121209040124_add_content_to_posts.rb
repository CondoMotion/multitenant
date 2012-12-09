class AddContentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content, :text
    add_column :posts, :attachment, :string
  end
end
