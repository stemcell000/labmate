class Organization < ApplicationRecord
 
 has_many :departments 
  
 validates :name, presence: true, allow_nil: false,  on: [:create, :update]
 validates :acronym, presence: true, length: {maximum: 4, minimum: 2}, allow_nil: false
end
