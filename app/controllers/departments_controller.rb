class DepartmentsController < InheritedResources::Base
  before_action :find_department, only: [:edit, :destroy, :update]
  
  #Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper
  
 def new
   @department = Department.new
 end
 
 
 def edit
 end
 
 def create
    @department = Department.create(department_params)
    if @department.valid?
      flash.keep[:success] = "A new department has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  def update
    @department.update_attributes(department_params)
  end
 
 def index
  @q = Department.ransack(params[:q])
  @locations = @q.result(distinct: true)
  #Config de l'affichage des résultats.
  @departments = smart_listing_create(:departments, Department.all, partial: "departments/smart_listing/list", default_sort: {name: "asc"},  page_sizes: [10, 20, 30, 50, 100])   
 end
 
 def destroy
    @department.destroy
 end
    
  private

    def department_params
      params.require(:department).permit(:name, :organization_id, :comment, :id)
    end
    
 def find_department
      @department = Department.find(params[:id])
 end

end

