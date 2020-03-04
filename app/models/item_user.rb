class ItemUser < ApplicationRecord
  self.table_name = "items_users"
  belongs_to :user
  belongs_to :item
end
