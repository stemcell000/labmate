class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :edit_hr, :update, :destroy, :editadmin, :show]
  before_action :set_option, only: [:index]
  before_action :set_roles, only: [:edit, :edit_hr]
   
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
   def index
   
    @departments = Department.all.order(name: "asc").uniq.map{ |obj| [obj['name'], obj['id']]}
    @teams = Team.where.not(name: 'Public').order(name: "asc").uniq.map{ |obj| [obj['name'], obj['id']] }
    @q = User.ransack(params[:q])
    
    results = @q.result.includes(:teams, :location, :departments)
    
      
    if !@option.display_all_users
        @users = results.where.not(role: 'superadmin', active_status: false)
    elsif can? :manage, User
        @my_selection = "Display all"
        @users = results.where.not(role: 'superadmin')
    else
        @my_selection = "My team(s) only"
        @users = @users.joins(:teams).where(:teams=>{:id => current_user.teams.ids})
    end

    #Config de l'affichage des résultats.
      @users = smart_listing_create(:users, @users, partial: "users/smart_listing/list",
                                                  default_sort: {lastname: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50, 100])
 end
 
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.valid?
      render :action => :show
      flash.keep[:success] = "A new user has been successfully created!"
      #
      set_adds(@user)
      #
      if ['superadmin', 'administrator'].include? @user.role
        @user.teams.destroy_all
        Team.all.each do |team|
          @user.teams << team
         end
      end
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def edit_hr
  end
  
  def update
    @user.update_attributes(user_params)
    if @user.valid?
      flash.keep[:success] = "Profile udpated."
      if ['superadmin', 'administrator'].include? @user.role
        @user.teams.destroy_all
        Team.all.each do |team|
          @user.teams << team
        end
        set_adds(@user)
      end
      redirect_to user_path
    else
      render :action => :edit
    end
  end
  
  def show
    
  end
  
 def destroy
   @user.role = 'former_employee'
   #
   if @user.items.exists
     @user.items.each do |item|
       item.generate_recap
     end
   end
   #
   @user.items.delete
 end
    
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
 def user_params
    params.require(:user).permit(:username, :email, :firstname, :lastname, :location_id, :role, :login, :recap, :password, :password_confirmation,
    :tel1, :tel2, :start_date, :end_date, :active_status,
    team_ids: [], teams_attributes: [:id, :name],
    location_attributes: [:id, :name, :building_id],
    position_ids: [], position_attributes: [:id, :name],
    options_attributes: [:display_all])
 end
 
 def set_option
    @option = current_user.options.first
 end
 
 def set_adds(user)
   user.generate_recap
   user.set_username
   user.humanize_name
   user.create_option
 end
 
 def set_roles
     @roles_list = [["superadmin", t('roles.superadmin')],
      ["administrator", t('roles.administrator')],
      ["HR_administrator", t('roles.hr_administrator')],
      ["inventory_manager", t('roles.inventory_manager')],
      ["team_leader" , t('roles.team_leader')],
      ["user" , t('roles.user')]]
 end
 
end
