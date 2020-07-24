class CategoriesController < InheritedResources::Base
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  #Load_and_authorize_resource
  before_action :set_category, only: [:edit, :update, :destroy, :show]
  
  #Index
 def index
    
    @superadmin = Team.where(name: "system admin")
    @option = current_user.options.first
    
      @q = Category.ransack(params[:q])
      @categories = @q.result(distinct: true)
      #Config de l'affichage des résultats.
      @categories = smart_listing_create(:categories, @categories, partial: "categories/smart_listing/listing",
                                                  default_sort: {name: "asc"},
                                                  page_sizes: [30, 50])
  end  

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.create(category_params)
    if @category.valid?
      flash.keep[:success] = t('global.menu.category') +" "+ t('global.createdf')
      redirect_to category_path(@category)
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    @category.update_attributes(category_params)
    if @category.valid?   
      flash.keep[:success] = t('global.menu.category') +" "+ t('global.updatedf')
      redirect_to category_path(@category)
    else
      render :action => 'edit'
    end
  end
  
  def show
    
  end
  
 def destroy
    @category.destroy
  end
  
  private

    def category_params
      params.require(:category).permit(:name, :acronym)
    end
    
    def set_category
      @category = Category.find(params[:id])
    end
end

