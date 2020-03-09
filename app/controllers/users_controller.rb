class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :editadmin, :show]
  before_action :set_option, only: [:index]
   
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
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.valid?
      flash.keep[:success] = "A new user has been successfully created!"
      #
      @user.create_option
      @user.update_columns(recap: @user.generate_recap)
      #
      if ['superadmin', 'administrator'].include? @user.role
        @user.teams.destroy_all
        Team.all.each do |team|
          @user.teams << team
         end
      end
      redirect_to 'users'
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    @user.update_attributes(user_params)
    if @user.valid?
      flash.keep[:success] = "Profile udpate."
      if ['superadmin', 'administrator'].include? @user.role
        @user.teams.destroy_all
        Team.all.each do |team|
          @user.teams << team
        end
        @user.update_columns(recap: @user.generate_recap)
      end
      redirect_to users_path
    else
      render :action => :edit
    end
  end
  
  def show
    
  end
  
 def index
   
    @departments = Department.all.order(name: "asc").uniq.map{ |obj| [obj['name'], obj['id']]}
    @teams = Team.where.not(name: 'Public').order(name: "asc").uniq.map{ |obj| [obj['name'], obj['id']] }
    @q = User.ransack(params[:q])
    @users = @q.result.includes(:teams, :location, :departments).where.not(role: 'superadmin')
 
    if @option.display_all_users
      @users = @users.joins(:teams).where(:teams=>{:id => current_user.teams.ids})
    end
    
     #Config de l'affichage des résultats.
      @users = smart_listing_create(:users, @users, partial: "users/smart_listing/list",
                                                  default_sort: {lastname: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50, 100])
 end
 
 def destroy
   @user.destroy
   if @user.items.exists
     @user.items.each do |item|
       item.generate_recap
     end
   end
 end
    
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
 def user_params
    params.require(:user).permit(:username, :email, :firstname, :lastname, :location_id, :role, :login, :recap, :password, :password_confirmation,
    :tel1, :tel2,
    team_ids: [], teams_attributes: [:id, :name],
    location_attributes: [:id, :name, :building_id],
    position_ids: [], position_attributes: [:id, :name],
    options_attributes: [:dispay_all])
 end
 
 def set_option
    @option = current_user.options.first
 end
 
end
