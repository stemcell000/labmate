class AddDefaultCurrencyToItem < ActiveRecord::Migration
  def change
    add_column :items, :default_currency, :string
  end
end
