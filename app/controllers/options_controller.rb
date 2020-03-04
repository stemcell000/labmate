class OptionsController < InheritedResources::Base
 
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

before_action :set_option, only: [:edit, :update]
before_action :set_current_user_option, only: [:display_all_switch, :display_all_users_switch, :display_all_contracts_switch]

def display_all_switch
  @option.toggle!(:display_all)
  redirect_to :controller => 'items', :action => 'index', :id => @option.id
end 

def display_all_users_switch
  @option.toggle!(:display_all_users)
  redirect_to :controller => 'users', :action => 'index', :id => @option.id
end 

def display_all_contracts_switch
  @option.toggle!(:display_all_contracts)
  redirect_to :controller => 'contracts', :action => 'index', :id => @option.id
end 

  private
    def set_option
      @option = Option.find(params[:id])
    end
    
    def set_current_user_option
      @option = current_user.options.first
    end

    def option_params
      params.require(:option).permit(:id, :display_all, :display_all_users, :display_all_contracts)
    end

end
