class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.boolean :display_all, :default => true
      t.timestamps
    end
  end
end
