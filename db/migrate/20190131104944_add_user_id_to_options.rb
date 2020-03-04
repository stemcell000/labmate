class AddUserIdToOptions < ActiveRecord::Migration
  def change
    add_column :options, :iser_id, :integer
  end
end
