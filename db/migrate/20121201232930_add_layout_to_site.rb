class AddLayoutToSite < ActiveRecord::Migration
  def change
    add_column :sites, :layout, :string
    add_column :sites, :custom_layout_content, :text
  end
end
