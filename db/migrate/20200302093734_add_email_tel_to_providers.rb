class AddEmailTelToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :email, :string
    add_column :providers, :tel, :integer
  end
end
