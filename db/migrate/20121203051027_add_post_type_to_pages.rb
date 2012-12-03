class AddPostTypeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :post_type, :string
  end
end
