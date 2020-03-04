class CreateReference < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :name
      t.string :tag
      t.timestamps
    end
  end
end
