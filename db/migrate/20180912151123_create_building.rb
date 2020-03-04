class CreateBuilding < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.integer :organization_id
      t.text :address
      t.string :zipcode
      t.string :city
      t.string :country
    end
  end
end
