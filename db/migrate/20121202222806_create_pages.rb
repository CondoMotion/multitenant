class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.string :ancestry
      t.references :company
      t.references :site

      t.timestamps
    end
    add_index :pages, :ancestry
    add_index :pages, :company_id
    add_index :pages, :site_id
  end
end
