class RemovePublicFromContracts < ActiveRecord::Migration
  def change
    remove_column :contracts, :public
  end
end
