class RemoveFoundFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :found
  end
end
