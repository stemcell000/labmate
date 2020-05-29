class CreateUserAttachments < ActiveRecord::Migration
    def change
    create_table :user_attachments do |t|
      t.integer :user_id
      t.string :attachment
      t.string :doc_type
      t.string :name
      t.timestamps null: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :user_attachments
  end
end
