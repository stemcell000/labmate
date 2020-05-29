class BuildingsController < ApplicationController
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  #Load_and_authorize_resource
  before_action :set_building, only: [:edit, :update, :destroy, :show]
  
  #Index
 def index
    
      @q = Building.ransack(params[:q])
      @buildings = @q.result(distinct: true)
      #Config de l'affichage des résultats.
      @buildings = smart_listing_create(:buildings, @buildings, partial: "buildings/smart_listing/listing",
                                                  default_sort: {id: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50])
  end  

  def new
    @building = building.new
  end
  
  def create
    @building = building.create(building_params)
    if @building.valid?
      flash.keep[:success] = t('menu.building') +" "+ t('global.createdf')
      redirect_to building_path(@building)
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    @building.update_attributes(building_params)
    if @building.valid?   
      flash.keep[:success] = t('menu.building') +" "+ t('global.updatedf')
      redirect_to building_path(@building)
    else
      render :action => 'edit'
    end
  end
  
  def show
    
  end
  
 def destroy
    @building.destroy
  end
    private
    
    def set_building
      @building = Building.find(params[:id])
    end

    def building_params
      params.require(:building).permit(:name, :organization_id, :address, :zipcode, :city, :country)
    end
end
