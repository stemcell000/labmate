class AddCommentToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :comment, :text
  end
end
