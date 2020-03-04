class Ability
  include CanCan::Ability

 def initialize(user)
    user ||= User.new # guest user (not logged in)
    
      if user.role? :superadmin
          can :manage, :all
      elsif user.role? :administrator
          can :manage, Item
          can :manage, Contract
          can :manage, User
          can :manage, Department
          can :manage, Team
          can :manage, Provider
      elsif user.role? :HR_administrator
          can :manage, User
      elsif user.role? :inventory_manager
          can :manage, Item 
          can :manage, Contract
          can :manage, User
     elsif user.role? :team_leader
          can :create, :read, :update, Item
          can :manage, Contract
          can :manage, User
          can :read, :update, Team
      elsif user.role? :user
          can :index, User
          can :update, User
          can :manage,  Item
          can :create, :edit, :read, :update, Contract
      elsif user.role? :guest
         can :read, Item
         can :read, User
      end
    end
    
   ActiveAdmin::ResourceController.class_eval do
    protected
  
    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end
    end
  end
