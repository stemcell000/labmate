class AddStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :active_status, :boolean, default: true
  end
end
