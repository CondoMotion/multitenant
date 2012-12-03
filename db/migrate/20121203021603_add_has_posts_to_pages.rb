class AddHasPostsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :has_posts, :boolean
    remove_column :pages, :has_sites
  end
end
