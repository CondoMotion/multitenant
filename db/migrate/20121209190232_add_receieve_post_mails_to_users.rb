class AddReceievePostMailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_post_mails, :boolean, default: true
  end
end
