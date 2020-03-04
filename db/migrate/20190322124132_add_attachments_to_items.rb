class AddAttachmentsToItems < ActiveRecord::Migration
  def change
       create_table :attachments do |t|
        t.integer :item_id
        t.string :attachment
        t.string :doc_type
        t.string :name
      t.timestamps null: false
    end
  end
end
