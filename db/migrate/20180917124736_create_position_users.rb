class CreatePositionUsers < ActiveRecord::Migration
  def change
    create_table :positions_users do |t|
        t.belongs_to :position, index: true
        t.belongs_to :user, index: true 
      t.timestamps
    end
  end
end
