class RemoveCurrencyFromItem < ActiveRecord::Migration
  def change
    remove_column :items, :currency
    remove_column :items, :default_currency
    add_column :items, :currency_id, :integer
  end
end
