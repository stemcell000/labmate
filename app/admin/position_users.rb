ActiveAdmin.register PositionUser do

active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {},
               batch_size: 1000 

end
