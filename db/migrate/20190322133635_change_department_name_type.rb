class ChangeDepartmentNameType < ActiveRecord::Migration
  def change
    change_column :departments, :name, :string
  end
end
