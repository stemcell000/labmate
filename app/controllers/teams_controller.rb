class TeamsController < InheritedResources::Base
load_and_authorize_resource
 before_action :find_team, only: [:edit, :destroy, :update]
 before_action :set_collections, only: [:new, :edit]
  
  #Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper
  
 def new
   @team = Team.new
 end
 
 
 def edit
 end
 
 def create
    @team = Team.create(team_params)
    if @team.valid?
      flash.keep[:success] = "A new team has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  def update
      @team.attributes = team_params
    if @team.save!
      flash.keep[:success] = "Team updated"
    else
      render :action => 'edit'
    end
  end
 
 def index
    @teams = smart_listing_create(:teams, Team.all, partial: "teams/smart_listing/list", default_sort: {name: "asc"},  page_sizes: [10, 20, 30, 50, 100])   
 end
 
 def destroy
   @team.destroy
 end
    
  private

    def team_params
      params.require(:team).permit(:id, :name, :department_id, :acronym, :type_id)
    end   
   
   def find_team
      @team = Team.find(params[:id])
   end
   
   def set_collections
     @departments = Department.all
     @types = Type.all
   end

end

