class Category < ApplicationRecord
 scope :belongs_to_items_coll, -> items_collection {joins(:items).where(:items => {id: items_collection})}
   before_save :uppercase_fields
 
 
  has_many :items
  has_and_belongs_to_many :contracts, join_table: "categories_contracts"
  
  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :contracts
  
  def uppercase_fields
    self.name.upcase
  end
  
end
