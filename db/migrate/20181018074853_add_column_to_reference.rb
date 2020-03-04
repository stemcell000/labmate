class AddColumnToReference < ActiveRecord::Migration
  def change
    add_column :references, :language, :string
  end
end
