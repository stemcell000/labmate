class ProvidersController < InheritedResources::Base
#Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  #Load_and_authorize_resource
  before_action :set_provider, only: [:edit, :update, :destroy]
  
  #Index
 def index
    
    @superadmin = Team.where(name: "system admin")
    @option = current_user.options.first
    
      @q = Provider.ransack(params[:q])
      @providers = @q.result(distinct: true)
      #Config de l'affichage des résultats.
      @providers = smart_listing_create(:providers, @providers, partial: "providers/smart_listing/listing",
                                                  default_sort: {name: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50])
  end  

  def new
    @provider = Provider.new
  end
  
  def create
    @provider = Provider.create(provider_params)
    if @provider.valid?
      flash.keep[:success] = 'Provider created'
      redirect_to provider_path(@provider)
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    @provider.update_attributes(provider_params)
    if @provider.valid?   
      flash.keep[:success] = 'Provider updated'
      redirect_to provider_path(@provider)
    else
      render :action => 'edit'
    end
  end
  
 def destroy
    @provider.destroy
  end
  
  private
    def provider_params
      params.require(:provider).permit(:name, :tel, :email, :address)
    end
    
    def set_provider
      @provider = Provider.find(params[:id])
    end
end

