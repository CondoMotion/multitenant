class AddHasSitesToPages < ActiveRecord::Migration
  def change
    add_column :pages, :has_sites, :boolean
  end
end
