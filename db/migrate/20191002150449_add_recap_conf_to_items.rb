class AddRecapConfToItems < ActiveRecord::Migration
  def change
    add_column :items, :recap_conf, :text
  end
end
