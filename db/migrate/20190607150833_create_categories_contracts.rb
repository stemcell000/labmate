class CreateCategoriesContracts < ActiveRecord::Migration
  def change
    create_table :categories_contracts do |t|
      t.belongs_to :category, index: true
      t.belongs_to :contract, index: true
      t.timestamps
    end
  end
end
