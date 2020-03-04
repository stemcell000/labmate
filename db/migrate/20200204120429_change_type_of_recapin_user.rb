class ChangeTypeOfRecapinUser < ActiveRecord::Migration
  def change
    change_column :users, :recap, :text
  end
end
