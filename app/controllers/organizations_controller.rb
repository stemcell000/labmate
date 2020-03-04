class OrganizationsController < InheritedResources::Base
  
  before_action :set_organization, only: [:edit, :show, :update]
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.create(organization_params)
    if @organization.valid?
      flash.keep[:success] = "Organization created !"
      render :action => :index
    else
      render :action => :new
    end
  end
  
  def edit
    
  end

  def update
       
    @organization.update_attributes(organization_params)
    
    if @organization.valid?
      flash.keep[:success] = "Organization updated !"
      redirect_to(@organization)
    else
      render :action => :edit
    end
    
  end

  private
  
    def set_organization
      @organization = Organization.first
    end

    def organization_params
      params.require(:organization).permit(:name, :acronym)
    end
end

