class Occurance < ActiveRecord::Base
  belongs_to :item
  has_many :days
  accepts_nested_attributes_for :days, :allow_destroy=>true
end
