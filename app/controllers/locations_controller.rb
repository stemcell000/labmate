class LocationsController < InheritedResources::Base
 #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  #Load_and_authorize_resource
  before_action :set_location, only: [:edit, :update, :destroy, :show]
  
  #Index
 def index
    
      @q = Location.ransack(params[:q])
      @locations = @q.result(distinct: true)
      #Config de l'affichage des résultats.
      @locations = smart_listing_create(:locations, @locations, partial: "locations/smart_listing/listing",
                                                  default_sort: {id: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50])
  end  

  def new
    @location = location.new
  end
  
  def create
    @location = location.create(location_params)
    if @location.valid?
      flash.keep[:success] = t('menu.location') +" "+ t('global.createdf')
      redirect_to location_path(@location)
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    @location.update_attributes(location_params)
    if @location.valid?   
      flash.keep[:success] = t('menu.location') +" "+ t('global.updatedf')
      redirect_to location_path(@location)
    else
      render :action => 'edit'
    end
  end
  
  def show
    
  end
  
 def destroy
    @location.destroy
  end
  
  private

    def set_location
      @location = Location.find(params[:id])
    end
 
    def location_params
      params.require(:location).permit(:name, :building_id)
    end
end

