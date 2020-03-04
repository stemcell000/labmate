class AddItemUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :item_user_id, :integer
  end
end
