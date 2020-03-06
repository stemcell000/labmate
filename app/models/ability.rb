class Ability
  include CanCan::Ability

 def initialize(user)
    user ||= User.new # guest user (not logged in)
    
      if user.role? :superadmin
        #superadmin can manage all
          can :manage, :all
      elsif user.role? :administrator
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
        #Inventory manager can only manage items that belongs to his/her team(s)
          can :manage, Item, item: {item_teams: {team_id: user.team_ids}}
        #Inventory manager can only manage contracts that belongs to his/her team(s)
          can :manage, Contract, contract: {contract_teams: {team_id: user.team_ids}}
        #Inventory manager can only manage user who belongs to his/her team(s)
          can :index, :read, User
          can :create, :update, User, user: {team_users: {team_id: user.team_ids}}
     elsif user.role? :team_leader
       #Team Leader can only manage users who belongs to his/her team(s)
          can :index, :read, User
          can :manage, User, user: {team_users: {team_id: user.team_ids}}
        #Team Leader can only manage items that belongs to his/her team(s)
          can :index, :read, Item
          can :create,  :update, Item, item: {item_teams: {team_id: user.team_ids}}
        #Team Leader can only manage his/her teams
          can :index, read, Team
          can :update, Team, team: {team_users: {user_id: user.id}}
        #Team Leader can only manage contracts that belongs to his/her team(s) or public tender  
          can :create, Contract
          can :update, :read, Contract do |c|
            user.contracts.exists?(c.id) || c.tender == true
          end
      elsif user.role? :user
        #User can only update him/herself
          can :index, :read, User
          can :update, User, id: user.id
        #User can only manage items that belongs to his/her team(s)
          can :create,  :update, Item, item: {item_teams: {team_id: user.team_ids}}
        #User can only manage contracts that belongs to his/her team(s) or public tender 
          can :create, Contract
          can :update, :read, Contract do |c|
            user.contracts.exists?(c.id) || c.tender == true
          end
      elsif user.role? :guest
         can :index, :read, Item
         can :index, :read, User
      end
    end
    
   ActiveAdmin::ResourceController.class_eval do
    protected
  
    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end
    end
  end
