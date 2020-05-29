class Ability
  include CanCan::Ability

 def initialize(user)
   alias_action :create, :read, :update, :destroy, to: :crud
   alias_action :create, :read, :update, to: :cru

    user ||= User.new # guest user (not logged in)
    
      if user.role? :superadmin
        #superadmin can manage all
          can :manage, :all
          can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "superadmin"
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
      ####HR ADMINISTRATOR
      elsif user.role? :HR_administrator
        #HR_administrator can manage users only
          can :manage, User
      ####INVENTORY MANAGER
      elsif user.role? :inventory_manager
          can :read, :all
        #Inventory manager can only manage items that belongs to his/her team(s)
          can :crud, Item, id: Item.by_teams(user.team_ids).map{ |item| item.id }
        #Inventory manager can only manage contracts that belongs to his/her team(s)
          can :manage, Contract, id: Contract.belongs_to_teams(user.team_ids).map{|contract| contract.id}
          can :index, User
        #Inventory manager can create and update brands and providers
          can :cru, Brand
          can :cru, Provider
      ####TEAM LEADER
     elsif user.role? :team_leader
         can :read, :all
         cannot :read, ActiveAdmin::Page, namespace_name: "admin"
         #User can only update him/herself
          can :index, User
          can :update, User, id: user.id
        #User can only manage items that belongs to his/her team(s)
          #can :cru, Item, item: {item_teams: {team_id: user.team_ids}}
          can :cru, Item, id: Item.is_managed_by(user.id).map { |item| item.id }
        #User can only manage contracts that belongs to his/hers or public tender 
          can :create, Contract
          can :update, Contract, user_id: user.id
          #User can only destroy contracts that belongs to his/hers
          can :destroy, Contract, user_id: user.id
          can :add_to_queue, Contract, id: Contract.belongs_to_teams(user.team_ids).map {|contract| contract.id}
          can :update_queue, Contract, id: Contract.belongs_to_teams(user.team_ids).map {|contract| contract.id}
        #User can create and update brands and providers
          can :cru, Brand
          can :cru, Provider
     #####USER
     elsif user.role? :user
         can :read, :all
         cannot :read, ActiveAdmin::Page, namespace_name: "admin"
        #User can only update him/herself
          can :index, User
          can :update, User, id: user.id
        #User can only manage items that belongs to his/her team(s)
          #can :cru, Item, item: {item_teams: {team_id: user.team_ids}}
          can :create, Item
          can :update, :destroy, Item, Item, id: Item.is_managed_by(user.id).map { |item| item.id }
        #User can only manage contracts that belongs to his/hers or public tender 
          can :create, Contract
          can :update, Contract, user_id: user.id
          #User can only destroy contracts that belongs to his/hers
          can :destroy, Contract, user_id: user.id
          can :add_to_queue, Contract, id: Contract.belongs_to_teams(user.team_ids).map {|contract| contract.id}
          can :update_queue, Contract, id: Contract.belongs_to_teams(user.team_ids).map {|contract| contract.id}
        #User can create and update brands and providers
          can :cru, Brand
          can :cru, Provider
    end
    
   ActiveAdmin::ResourceController.class_eval do
    protected
  
      def current_ability
        @current_ability ||= AdminAbility.new(current_user)
      end
    end
end 
end