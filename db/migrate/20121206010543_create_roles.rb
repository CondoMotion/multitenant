class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :site
      t.integer :permission

      t.timestamps
    end
    add_index :roles, :site_id
  end
end
