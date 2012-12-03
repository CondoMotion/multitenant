class RemoveTopicIdFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :topic_id
  end

  def down
    add_column :posts, :topic_id, :integer
  end
end
