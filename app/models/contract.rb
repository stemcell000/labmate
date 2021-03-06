class Contract < ActiveRecord::Base
  scope :belongs_to_teams, -> teams_array {joins(:teams).where(:teams => {id: teams_array})}
  scope :belongs_to_categories, -> categories_array {joins(:categories).where(:categories => {id: categories_array})}
  scope :belongs_to_items, -> items_array {joins(:contracts_items).where(:contracts_items=> {item_id: items_array})}
  scope :is_tender, -> {where(tender: true)}
  scope :is_not_tender, -> {where(tender: false)}
  
  has_and_belongs_to_many :items, join_table: "contracts_items"
  has_and_belongs_to_many :categories, join_table: "categories_contracts"
  has_and_belongs_to_many :teams, join_table: "contracts_teams"
  has_many :attachments, :dependent => :destroy
 
  belongs_to :currency
  belongs_to :provider
  belongs_to :user

  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :currency
  accepts_nested_attributes_for :teams
  accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :provider
  

  validates :name, presence: true
  validates :categories, presence: true
  validates :provider, presence: true
  validates :teams, presence: true
  validates :end_date, presence: true
  validates :start_date, presence: true

end
