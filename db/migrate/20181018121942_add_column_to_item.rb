class AddColumnToItem < ActiveRecord::Migration
  def change
    add_column :items, :contract_id, :string
  end
end
