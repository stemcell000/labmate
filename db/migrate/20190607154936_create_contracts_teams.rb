class CreateContractsTeams < ActiveRecord::Migration
  def change
    create_table :contracts_teams do |t|
      t.belongs_to :team, index: true
      t.belongs_to :contract, index: true
      t.timestamps
    end
  end
end
