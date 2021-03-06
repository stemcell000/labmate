ActiveAdmin.register Building do

permit_params :id, :name, :organization_id, :address, :zipcode, :city, :country

active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                 Building.where(id: importer.values_at('id')).delete_all
               },
               batch_size: 1000 
end
