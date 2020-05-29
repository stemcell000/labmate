class Item < ApplicationRecord
  after_create :generate_recap
  after_update :generate_recap
  scope :orphan, -> {joins("LEFT JOIN items_users ON items.id = items_users.item_id").where("items_users.item_id IS NULL")}
  scope :without_team, -> {joins("LEFT JOIN items_teams ON items.id = items_teams.item_id").where("items_teams.item_id IS NULL")}
  scope :by_teams,  ->(team_id) { joins(:teams).where(teams: { id: team_id }).order(:id) }
  scope :is_managed_by, ->(user_id){ joins(:item_users).where(:items_users => {user_id: user_id})}
  scope :without_contract, ->{joins("LEFT JOIN contracts_items ON items.id = contracts_items.item_id").where("contracts_items.item_id IS NULL")}
  scope :by_contract, ->(contract_id){joins(:contracts).where(contracts: {id: contract_id}).order(:name)}
  scope :by_obsolete_contract, ->{joins(:contracts).where("end_date<?", Date.today).order(:name)}
  
  has_many :item_users
  has_many :occurances
  has_many :users, through: :item_users
  has_and_belongs_to_many :teams, join_table: "items_teams"
  has_many :item_attachments, :dependent => :destroy
  has_and_belongs_to_many :contracts, join_table: "contracts_items"
  
  belongs_to :brand
  belongs_to :category
  belongs_to :provider
  belongs_to :owner
  belongs_to :location
  belongs_to :status
  belongs_to :currency
  
  accepts_nested_attributes_for :teams
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :contracts
  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :category
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :status
  accepts_nested_attributes_for :currency
  accepts_nested_attributes_for :item_attachments, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :occurances, :allow_destroy => true, reject_if: :all_blank
  
  def check_manager(user_id)
    self.users.where(user_id).exists?
  end
  
  def check_orphan
    self.users.nil?
  end
  
  def label
    "#{barcode} #{name}".truncate(65)
  end
  
  validates :name, presence: true
  
  
  def generate_recap
    
    status_name = self.status.nil? ? '-' : self.status.name
    full_name = self.users.nil? ? 'None' : self.users.map{|u| "<a href = 'mailto:#{u.email}'>#{u.full_name}</a>" }.to_sentence
    address = self.users.nil? ? '' : self.users.map{|u| u.email}
    team_name = self.teams.nil? ? '-' : self.teams.map{|t| t.name}.to_sentence
    location_name = self.location.nil? ? '-' : self.location.name
    category_name = self.category.nil? ? '-' : self.category.name
    installation_date = self.installation_date.nil? ? '-' : self.installation_date.strftime('%b %e, %Y')
    created_at = self.created_at.nil? ? '-' : self.created_at.strftime('%b %e, %Y')
    serial_number = self.serial_number.nil? ? '-': self.serial_number
    provider_name = self.provider.nil? ? '-' : self.provider.name
    brand_name = self.brand.nil? ? '-' : self.brand.name
    owner_name = self.owner.nil? ? '-' : self.owner.name
    owner_inventory = self.owner_inventory.nil? ? '-' : self.owner_inventory
    price = self.price == 0 ? '-' : self.price
    currency_name = self.currency.nil? ? '' : self.currency.name
    residue = self.residue == 0 ? '-' : self.residue
    folder_number = self.folder.nil? ? '-' : self.folder
    order = self.order.nil? ? '-' : self.order
    order_note = self.order_note.nil? ? '-': self.order_note
    invoice = self.invoice.nil? ? '-': self.invoice
    invoice_note = self.invoice_note.nil? ? '-': self.invoice_note
    comment = self.comment.nil? ? '-' : self.comment
    
   block = " 
        <div class='col-md-12'>
          <div class='row'>
            <strong>Status : </strong> #{ status_name  }
          </div>
          <div class='row'>
            <strong>Contact : </strong> #{ full_name}
          </div>
          <div class='row'>
            <strong>Team : </strong> #{ team_name}
          </div>
          <div class='row'>
            <strong>Location : </strong> #{ location_name }
          </div>
          <div class='row'>
            <strong>Category : </strong> #{ category_name }
          </div>
          <div class='row'>
            <strong>Installed on : </strong> #{ installation_date }
          </div>
          <div class='row'> 
            <strong>Registered on : </strong> #{ created_at }
          </div>
          <div class='row'>
            <strong>Serial number : </strong> #{ serial_number }
          </div>
          <div class='row'>
            <strong>Provider : </strong> #{ provider_name }
          </div>
          <div class='row'>
            <strong>Brand : </strong> #{ brand_name }
          </div>
           <div class='row'>
              <strong>Owner : </strong> #{ owner_name }
          </div>
           <div class='row'>
              <strong>Owner ID : </strong> #{ owner_inventory }
            </div>
           <div class='row'>
              <strong>Comment : </strong> #{ comment }
          </div>
          "
            
      block_conf= "
            <div class='row'>
              <strong>Price : </strong> #{ price } #{ currency_name }
            </div>
            <div class='row'>
              <strong>Residue : </strong> #{ residue }  #{ currency_name }
            </div>
            <div class='row'>
              <strong>Folder number : </strong> #{ folder }
            </div>
            <div class='row'>
              <strong>Order : </strong> #{ order }
            </div>
              <div class='row'>
                <strong>note : </strong> #{ order_note }
              </div>
            <div class='row'>
              <strong>Invoice : </strong> #{ invoice }
            </div>
            <div class='row'>
              <strong>note : </strong> #{ invoice_note }
            </div>
            "
            
            self.update_columns(:recap => block)
            self.update_columns(:recap_conf => block_conf)
  end
end