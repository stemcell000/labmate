class AddAddressToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :address, :hstore
  end
end
