class AddColumnAcronymToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :acronym, :string
  end
end
