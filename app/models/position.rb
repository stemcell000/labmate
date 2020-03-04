class Position < ApplicationRecord
 has_and_belongs_to_many :users, join_table: "positions_users"
 
 accepts_nested_attributes_for :users
end
