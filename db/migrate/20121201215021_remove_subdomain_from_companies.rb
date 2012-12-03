class RemoveSubdomainFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :subdomain
  end

  def down
    add_column :companies, :subdomain, :string
  end
end
