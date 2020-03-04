class AddLockedToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :locked, :boolean
  end
end
