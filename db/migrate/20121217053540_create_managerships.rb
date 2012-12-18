class CreateManagerships < ActiveRecord::Migration
  def change
    create_table :managerships do |t|
      t.references :user
      t.references :site

      t.timestamps
    end
    add_index :managerships, :user_id
    add_index :managerships, :site_id
  end
end
