ActiveAdmin.register Provider do



active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                 Item.where(id: importer.values_at('id')).delete_all
               },
               batch_size: 1000 


permit_params :name
end
