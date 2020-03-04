class RemoveStatusFromItem < ActiveRecord::Migration
  def change
    remove_column :items, :status
    add_column :items, :status_id, :integer
  end
end
