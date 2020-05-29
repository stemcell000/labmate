class CreateItemAttachments < ActiveRecord::Migration
    def change
    create_table :item_attachments do |t|
      t.integer :item_id
      t.string :attachment
      t.string :doc_type
      t.string :name
      t.timestamps null: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :item_attachments
  end
end
