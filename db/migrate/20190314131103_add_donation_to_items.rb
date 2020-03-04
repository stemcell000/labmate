class AddDonationToItems < ActiveRecord::Migration
  def change
    add_column :items, :donation, :boolean
  end
end
