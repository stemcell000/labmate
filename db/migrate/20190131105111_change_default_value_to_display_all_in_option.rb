class ChangeDefaultValueToDisplayAllInOption < ActiveRecord::Migration
  def change
    change_column_default(:options, :display_all, nil)
  end
end
