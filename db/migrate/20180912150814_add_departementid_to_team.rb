class AddDepartementidToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :department_id, :integer
  end
end
