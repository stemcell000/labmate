class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :name
      t.integer :organization_id

      t.timestamps
    end
  end
end
