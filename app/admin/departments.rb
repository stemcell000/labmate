ActiveAdmin.register Department do
permit_params :id, :name
active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                 Department.where(id: importer.values_at('id')).delete_all
               },
               batch_size: 1000 

end
