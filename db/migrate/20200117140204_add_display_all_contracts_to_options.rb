class AddDisplayAllContractsToOptions < ActiveRecord::Migration
  def change
    add_column :options, :display_all_contracts, :boolean
  end
end
