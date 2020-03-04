class AddDisplayAllUsersToOptions < ActiveRecord::Migration
  def change
    add_column :options, :display_all_users, :boolean
  end
end
