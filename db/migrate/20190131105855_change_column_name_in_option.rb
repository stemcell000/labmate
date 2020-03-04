class ChangeColumnNameInOption < ActiveRecord::Migration
  def change
    rename_column :options, :iser_id, :user_id
  end
end
