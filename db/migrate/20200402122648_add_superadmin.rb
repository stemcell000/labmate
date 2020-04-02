class AddSuperadmin < ActiveRecord::Migration
  def up    
         u = User.new
          u.email     = 'marc.lechuga@inserm.fr'
          u.username = 'mlechuga'
          u.firstname = 'Marc'
          u.lastname = 'Lechuga'
          u.encrypted_password   = 'stemcell'
          u.password = 'stemcell'
          u.password_confirmation = 'stemcell'
          u.role = 'administrator'
          u.save!(validate: false)
          u.options.create(display_all: false)
  end
  
  def down
  end
end
