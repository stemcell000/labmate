class CreateContractsItems < ActiveRecord::Migration
  def change
    create_table :contracts_items do |t|
      t.belongs_to :contract, index: true
      t.belongs_to :item, index: true
      t.timestamps
    end
  end
end
