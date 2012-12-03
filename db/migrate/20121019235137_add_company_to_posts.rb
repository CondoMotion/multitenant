class AddCompanyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :company_id, :integer
    add_index :posts, :company_id
  end
end
