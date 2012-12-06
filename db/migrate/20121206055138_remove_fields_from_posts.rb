class RemoveFieldsFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :fields_id
    remove_column :posts, :fields_type
  end

  def down
    add_column :posts, :fields_type, :string
    add_column :posts, :fields_id, :integer
  end
end
