class AddCompanyIdToManagerships < ActiveRecord::Migration
  def change
    add_column :managerships, :company_id, :integer
    add_index :managerships, :company_id
  end
end
