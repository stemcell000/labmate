class ContractsController < InheritedResources::Base

 #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 #Load_and_authorize_resource
  before_action :set_contract, only: [:edit, :update, :add_to_queue, :update_queue, :destroy]
  before_action :set_collections, only: [:edit, :update, :create, :new]
   
 #Index
 def index
    
    @superadmin = Team.where(name: "system admin")
    @option = current_user.options.first
    @users = User.all.order(lastname: "asc").map{ |obj| [(obj['firstname']+" "+obj['lastname']), obj['id']] }
    @categories = Category.all.order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    
    #"between search": recherche dans un range de dates
      
      #Formattage des dates
      start_time = params[:start_gteq].todate rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:end_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
      
      @users = User.all.order(lastname: "asc").map{ |obj| [(obj['firstname']+" "+obj['lastname']), obj['id']] }
      
      
      current_user_teams_ids = current_user.teams.map {|team| team.id}
      all_users_teams_ids = Team.all.map {|team| team.id}
    
        @q = Contract.ransack(params[:q])
        
          if ['superadmin', 'administrator'].include? current_user.role
             @contracts = @q.result(distinct: true).includes([ :items, :categories ])
          elsif ['inventory_manager'].include? current_user.role
             @contracts =  @q.result(distinct: true).includes([ :items, :categories ]).where(id: current_user_teams_ids)
          else
             @contracts = @q.result(distinct: true).includes([ :items, :categories ]).belongs_to_teams(current_user_teams_ids)
             @categories = current_user.items.map{|item| item.contract}
          end

      if @option.display_all_contracts
        @contracts = @contracts.where('end_date > ?', Date.today)
      end

      #Config de l'affichage des résultats.
      @contracts = smart_listing_create(:contracts, @contracts, partial: "contracts/smart_listing/listing",
                                                  default_sort: {id: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50])
  end  
  
  def new
    @contract = Contract.new
  end
  
  def create
    @contract = Contract.create(contract_params)
    if @contract.valid?
      flash.keep[:success] = 'Contract created'
      redirect_to contract_path(@contract)
      if @contract.teams.pluck(:name).any? {|name| name == 'All'}
        @contract.teams.destroy_all
        Team.all.where.not(name: ['system', 'all']).all.each do |team|
          @contract.teams << team
        end
      end
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    @contract.update_attributes(contract_params)
    if @contract.valid?   
      flash.keep[:success] = 'Contract updated'
      redirect_to contract_path(@contract)
      if @contract.teams.pluck(:name).any? {|name| name == 'All'}
        @contract.teams.destroy_all
        Team.all.where.not(name: ['system', 'all']).all.each do |team|
         @contract.teams << team
       end
       end
    else
      render :action => 'edit'
    end
  end
  
  def add_to_queue
    @contract_items = @contract.items
    items = Item.by_teams(@contract.teams.ids)
    @items = items.where(category_id: @contract.categories.ids)
  end
  
  def update_queue
    @contract.update_attributes(contract_params)
    if @contract.valid?   
      flash.keep[:success] = 'Contract updated - Selection added.'
      redirect_to :action => 'index'
    else
      render :action => 'add_to_queue'
    end
    
  end

  def destroy
    @contract.destroy
  end
  
  
  private
  
  def contract_params
      params.require(:contract).permit(:id, :start_date, :end_date, :register, :contract_number, :cost, :name, :provider_id, :tender, :locked,
      attachments_attributes: [:id, :item_id, :attachment, :remove_attachment, :doc_type, :_destroy],
      category_ids: [], team_ids: [])
  end
  
  def set_contract
    @contract =  Contract.find(params[:id])
  end
  
  def set_collections
     @providers = Provider.all
     @teams = Team.all.where.not(name: 'system')
    if ['superadmin', 'administrator'].include? current_user.role
      @categories = Category.all.order(name: "asc")
      @teams = Team.all
    else
      items = Item.by_teams(current_user.teams.ids)
      @teams = Team.all.where.not(name: ['system', 'all'])
      @categories = Category.belongs_to_items_coll(items.pluck(:id)).order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    end
   
  end
end

