class AddFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :fields_id, :integer
    add_column :posts, :fields_type, :string
  end
end
