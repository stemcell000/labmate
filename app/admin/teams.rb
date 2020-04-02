ActiveAdmin.register Team do

active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {Team.where(id: importer.values_at('id')).delete_all}
               

permit_params :name, :topic, :acronym, :type_id, :department_id
end
