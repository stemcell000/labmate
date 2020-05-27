class ContractsController < InheritedResources::Base
 #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 #Load_and_authorize_resource
  before_action :set_contract, only: [:edit, :update, :add_to_queue, :update_queue, :destroy, :show]
  before_action :set_collections, only: [:edit, :update, :create, :new, :show]
   
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
      
      current_user_teams_ids = current_user.team_ids
      current_user_items_ids = current_user.item_ids
    
        @q = Contract.ransack(params[:q])
        
          if can? :manage, Department
             @contracts = @q.result(distinct: true).includes([ :items, :categories ])
          else
            @categories = Category.from_items(current_user_items_ids)
             @contracts = @q.result(distinct: true).belongs_to_teams(current_user_teams_ids).includes([ :items, :categories ])
              
          end

      if @option.display_all_contracts
        @contracts = @contracts.where('end_date > ?', Date.today)
      end

      #Config de l'affichage des résultats.
      @contracts = smart_listing_create(:contracts, @contracts, partial: "contracts/smart_listing/listing",
                                                  default_sort: {id: "desc"},
                                                  page_sizes: [ 10, 20, 30, 50])
  end  
  
  def new
    @contract = Contract.new
  end
  
  def create
    @contract = Contract.create(contract_params)
    if @contract.valid?
      flash.keep[:success] = t('global.contract')+" "+t('global.createdm')
      redirect_to contract_path(@contract)
      current_user.contracts << @contract
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
      flash.keep[:success] = t('global.contract').capitalize+" "+t('global.updatedm')
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
    items = Item.by_teams(@contract.team_ids).where(category_id: @contract.categories.ids)
    coll1 = items.without_contract
    coll2 = items.by_contract(@contract.id)
    coll3 = items.by_obsolete_contract
    @items = coll1+coll2+coll3
  end
  
  def update_queue
    @contract.update_attributes(contract_params)
    if @contract.valid?   
      flash.keep[:success] = t('global.contract')+" "+t('global.updatedm')
      redirect_to :action => 'index'
    else
      render :action => 'add_to_queue'
    end
  end
  
  def show
  respond_to do |format|
    format.html
    format.xlsx{
      response.headers[
        'Content-Disposition'
      ] = "attachment; filename='items.xlsx'"
    }
  end
  end

  def destroy
    @contract.destroy
    redirect_to :action => 'index'
  end
  
  
  private
  
  def contract_params
      params.require(:contract).permit(:id, :start_date, :end_date, :register, :contract_number, :cost, :name, :provider_id, :currency_id, :user_id, :tender, :locked,
      attachments_attributes: [:id, :contract_id, :attachment, :remove_attachment, :doc_type, :_destroy],
      item_ids: [],
      items_attributes: [:id, :name],
      category_ids: [], team_ids: [])
  end
  
  def set_contract
    @contract =  Contract.find(params[:id])
  end
  
  def set_collections
     @providers = Provider.all
      
    if ['superadmin', 'administrator'].include? current_user.role
      @teams = Team.all.where.not(name: 'System').order(name: "asc")
      @categories = Category.all.order(name: "asc")
    else
      items = Item.by_teams(current_user.teams.ids)
      @categories = Category.from_items(items.ids).order(name: "asc").uniq
      @teams = current_user.teams
    end
   
  end
end

