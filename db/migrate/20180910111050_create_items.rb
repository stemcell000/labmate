class CreateItems < ActiveRecord::Migration
 def change
    create_table :items do |t|
      t.string :barcode
      t.string :name
      t.string :serial_number
      t.string :owner_inventory
      t.date :installation_date
      t.decimal :price
      t.decimal :residue
      t.decimal :interval
      t.decimal :duration
      t.decimal :amortization
      t.string :folder
      t.boolean :registered
      t.string :order
      t.text :order_note
      t.string :invoice
      t.text :invoice_note
      t.text :comment
      t.string :status
      t.boolean :deleted
      t.date :date_of_deletion
      t.integer :location_id
      t.integer :category_id
      t.integer :provider_id
      t.integer :brand_id
      t.integer :owner_id
      t.string :funding
   


      t.timestamps null: false
    end
  end
end
