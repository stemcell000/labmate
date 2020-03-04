class CreateItemAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :item_attachments do |t|
      t.integer :item_id
      t.string :name
      t.string :attachment
      t.timestamps
    end
  end
end
