class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :occurance_id
      t.date :date
      t.timestamps null: false
    end
  end
end
