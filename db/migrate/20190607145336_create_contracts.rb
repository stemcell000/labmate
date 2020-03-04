class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :provider_id
      t.text :comment
      t.float :price
      t.integer :currency_id
      t.boolean :public
      t.boolean :grouped
      t.string :number
      t.boolean :registered
      t.timestamps null: false
      add_column :attachments, :contract_id, :integer
    end
  end
end
