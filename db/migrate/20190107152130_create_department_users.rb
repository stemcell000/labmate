class CreateDepartmentUsers < ActiveRecord::Migration
  def change
    create_table :departments_users do |t|
       t.belongs_to :team, index: true
       t.belongs_to :user, index: true
    end
  end
end
