class AddManagerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :manager, :boolean
    remove_column :users, :admin
  end
end
