class RemoveRole < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: "guest"
  end
end
