class AddHasAttachmentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :has_attachment, :boolean, default: true
  end
end
