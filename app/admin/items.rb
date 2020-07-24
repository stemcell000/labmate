ActiveAdmin.register Item do
  
active_admin_import validate: true,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                 Item.where(id: importer.values_at('id')).delete_all
               },
               batch_size: 1000 

permit_params :list, :of, :attributes, :on, :model, :id, :name, :barcode, :serial_number, :owner_inventory,
:installation_date, :price, :residue, :interval, :duration, :amortization, :folder, :registered, :order,
:order_note, :invoice, :invoice_note, :comment, :deleted, :date_of_deletion, :location_id, :category_id, :brand_id, :owner_id,
:funding, :status_id, :currency_id, :contract_id, :donation,:created_at, :updated_at
end
