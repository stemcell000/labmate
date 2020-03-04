class AddItemUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :item_user_id, :integer
  end
end
