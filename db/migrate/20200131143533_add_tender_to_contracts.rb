class AddTenderToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :tender, :boolean
  end
end
