class Ability
  include CanCan::Ability

 def initialize(user)
   alias_action :create, :read, :update, :destroy, to: :crud
   alias_action :create, :read, :update, to: :cru
   
    user ||= User.new # guest user (not logged in)
    
      if user.role? :superadmin
        #superadmin can manage all
          can :manage, :all
      elsif user.role? :administrator
          can :read, :all
        #administrator can manage all except the organization
          can :manage, Item
          can :manage, Contract
          can :manage, User
          can :manage, Department
          can :manage, Team
          can :manage, Provider
          can :manage, Brand
          can :manage, Category
          can :manage, Owner
          can :manage, Location
          can :manage, Building
          can :manage, Status
          can :manage, Position
          can :manage, Type
      elsif user.role? :HR_administrator
        #HR_administrator can manage users only
          can :manage, User
      elsif user.role? :inventory_manager
          can :read, :all
        #Inventory manager can only manage items that belongs to his/her team(s)
          can :crud, Item do |item|
            user.teams.exists? item.teams
          end
        #Inventory manager can only manage contracts that belongs to his/her team(s)
          can :manage, Contract do |c|
            c.teams.exists? user.teams
          end
        #Inventory manager can only manage user who belongs to his/her team(s)
          can :crud, User do |u|
            user.teams.exists? u.teams
          end
        #Inventory manager can create and update brands and providers
          can :crud, Brand
          can :crud, Provider
       ####
     elsif user.role? :team_leader
          can :read, :all
       #Team Leader can only manage users who belongs to his/her team(s)
          can :index, User
          can :manage, User, user: {team_users: {team_id: user.team_ids}}
        #Team Leader can only manage items that belongs to his/her team(s)
          can :cru, Item do |item|
            user.teams.exists? item.teams
          end
        #Team Leader can only manage user who belongs to his/her team(s)
          can :crud, User do |u|
            user.teams.exists? u.teams
          end
        #Team Leader can only manage his/her teams
          can :index, read, Team
          can :update, Team, team: {team_users: {user_id: user.id}}
        #Team Leader can only manage contracts that belongs to his/her team(s) or public tender  
          can :cru, Contract do |c|
            user.contracts.exists?(c.id) || c.tender == true
          end
        #Team leader can create and update brands and providers
          can :cru, Brand
          can :cru, Provider
        ####
      elsif user.role? :user
         can :read, :all
        #User can only update him/herself
          can :index, User
          can :update, User, id: user.id
        #User can only manage items that belongs to his/her team(s)
          #can :cru, Item, item: {item_teams: {team_id: user.team_ids}}
          can :cru, Item do |item|
            #user.teams.exists?(item.team_ids)
            user.teams.exists? item.teams
          end
        #User can only manage contracts that belongs to his/hers or public tender 
          can :create, Contract
          can :update, Contract do |c|
            user.contracts.exists?(c.id) || c.tender == true
          end
        #User can only destroy contracts that belongs to his/hers
          can :destroy, Contract do |c|
            user.contracts.exists?(c.id)
          end
        #User can create and update brands and providers
          can :cru, Brand
          can :cru, Provider
          
      elsif user.role? :out
         cannot :manage, :all
       end
    end
   ActiveAdmin::ResourceController.class_eval do
    protected
  
    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end
    end
  end
