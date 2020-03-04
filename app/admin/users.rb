ActiveAdmin.register User do
 # This will authorize the Foobar class
 # The authorization is done using the AdminAbility class
#
permit_params :id, :email, :password, :password_confirmation, :role, :username, :firstname, :lastname  
# See permitted parameters documentation:
active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                 User.where(id: importer.values_at('id')).delete_all
               },
               batch_size: 1000 

end
