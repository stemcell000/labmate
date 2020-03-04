class AddColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :recap, :text
  end
end
