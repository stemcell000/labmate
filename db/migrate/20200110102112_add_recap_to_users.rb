class AddRecapToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recap, :string
  end
end
