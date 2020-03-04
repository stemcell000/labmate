class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :tel_fix
      t.string :mobile
      t.text :address
      t.string :zipcode
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
