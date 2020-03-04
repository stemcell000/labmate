ActiveAdmin.register Organization do

active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                Organization.where(id: importer.values_at('id')).delete_all
               },
               batch_size: 1000 


permit_params :name, :acronym
end
