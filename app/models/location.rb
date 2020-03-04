class Location < ApplicationRecord
  has_many :items
  has_many :users
  belongs_to :building
  accepts_nested_attributes_for :users  
  accepts_nested_attributes_for :building
end
