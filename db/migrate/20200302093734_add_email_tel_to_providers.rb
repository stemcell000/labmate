class AddEmailTelToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :email, :string
    add_column :providers, :tel, :integer
  end
end
