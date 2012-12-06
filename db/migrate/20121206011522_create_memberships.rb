class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :site
      t.references :user
      t.references :company
      t.references :role

      t.timestamps
    end
    add_index :memberships, :site_id
    add_index :memberships, :user_id
    add_index :memberships, :company_id
    add_index :memberships, :role_id
  end
end
