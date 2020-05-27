class Category < ApplicationRecord
 
  scope :from_items, -> item_ids {joins(:items).where(:items => {id: item_ids})}
  
  before_save :uppercase_fields
 
  has_many :items
  has_and_belongs_to_many :contracts, join_table: "categories_contracts"
  
  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :contracts
  
  def uppercase_fields
    self.name.upcase
  end
  
  validates :name, presence: true
  validates :acronym, presence: true
  
end
