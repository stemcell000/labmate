class CreateItemsReports < ActiveRecord::Migration
  def change
    create_table :items_reports do |t|
      t.belongs_to :item, index: true
      t.belongs_to :report, index: true
      t.timestamps
    end
  end
end
