class CreateItemTeams < ActiveRecord::Migration
 def change
    create_table :items_teams do |t|
      t.belongs_to :item, index: true
      t.belongs_to :team, index: true
      t.timestamps
    end
  end
end
