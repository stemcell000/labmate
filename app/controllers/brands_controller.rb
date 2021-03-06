class BrandsController < InheritedResources::Base
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  #Load_and_authorize_resource
  before_action :set_brand, only: [:edit, :update, :destroy, :show]
  
  #Index
 def index
    
      @option = current_user.options.first
    
      @q = Brand.ransack(params[:q])
      @brands = @q.result(distinct: true)
      #Config de l'affichage des résultats.
      @brands = smart_listing_create(:brands, @brands, partial: "brands/smart_listing/listing",
                                                  default_sort: {name: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50])
  end  

  def new
    @brand = Brand.new
  end
  
  def create
    @brand = Brand.create(brand_params)
    if @brand.valid?
      flash.keep[:success] = t('global.menu.brand') +" "+ t('global.createdf')
      redirect_to brand_path(@brand)
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    @brand.update_attributes(brand_params)
    if @brand.valid?   
      flash.keep[:success] = t('global.menu.brand') +" "+ t('global.updatedf')
      redirect_to brand_path(@brand)
    else
      render :action => 'edit'
    end
  end
  
  def show
    
  end
  
 def destroy
    @brand.destroy
  end
  
  private

    def brand_params
      params.require(:brand).permit(:name)
    end
    
    def set_brand
      @brand = Brand.find(params[:id])
    end
end

