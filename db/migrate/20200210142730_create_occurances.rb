class CreateOccurances < ActiveRecord::Migration
  def change
    create_table :occurances do |t|
      t.integer :item_id
      t.string :name
      t.text :comment
      t.boolean :done

      t.timestamps null: false
    end
  end
end
