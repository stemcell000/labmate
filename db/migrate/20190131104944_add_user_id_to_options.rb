class AddUserIdToOptions < ActiveRecord::Migration
  def change
    add_column :options, :user_id, :integer
  end
end
