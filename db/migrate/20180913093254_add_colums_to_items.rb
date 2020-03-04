class AddColumsToItems < ActiveRecord::Migration
  def change
    add_column :items, :found, :string
  end
end
