class Provider < ApplicationRecord
     before_save :uppercase_fields
  
  has_many :items
  has_many :contracts
  
  accepts_nested_attributes_for :contracts
  
  def uppercase_fields
    self.name.upcase
  end
  

end
