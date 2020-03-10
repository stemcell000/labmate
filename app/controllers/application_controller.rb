class ApplicationController < ActionController::Base
  #check_authorization :unless => :devise_controller?
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:set_locale]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :define_organization
  before_action :current_collections
  before_action :set_locale
  
  ActiveRecord::Base.connection.tables.each do |t|
   ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
  
  def configure_permitted_parameters
    added_attrs = [:username, :email, :firstname, :lastname, :location_id, :recap, :role, :password, :password_confirmation, :remember_me, {team_ids: []}, {position_ids: []}, teams_attributes:[:id, :name, :acronym], positions_attributes:[:id, :name]]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def define_organization
    @brand = Organization.first.nil? ? "": "- " + Organization.first.name
  end
  
  def toggle_display
    @current_user = current_user
    @current_user.toggle(:display)
  end
  
  def check_for_orphans
    if current_user
      unless Item.by_teams(@current_user_teams_ids).orphan.nil?
        orphans = Item.by_teams(@current_user_teams_ids).orphan
        n_orphans = orphans.size
        orphans_bc = orphans.pluck(:barcode)
        if n_orphans > 0
          flash.now[:error] = "<small>#{t('global.flash_orphans')} #{t('global.orphan_item', count: n_orphans)} : #{orphans_bc.to_sentence}</small>".html_safe
        end
      end
     end
   end
   
   def check_for_tenders
     if current_user
      #check for public unlocked and on-going tender (contract) 
      on_going_tenders = Contract.where(tender: true).where(locked: false).where("end_date>?",Date.today)
       if on_going_tenders.any?
         #check if the current user's teams are concerned by the on-going tender
         on_going_tenders.each do |tender|
         if tender.teams & current_user.teams 
           #check if the current user's teams items categories are concerned by the on going tender
            if tender.categories & @current_teams_categories
              flash.now[:success] = t('global.flash_tender', category:tender.categories.pluck(:name).to_sentence.humanize)
            end
          end
         end
         end
         end
       end
  
   rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

private
  
  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
  
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
  def default_url_options
    { locale: I18n.locale }
  end
 
  def current_collections
    if current_user
      @current_user_teams_ids = current_user.teams.map {|team| team.id}
      @current_teams_items = Item.by_teams(@current_user_teams_ids)
      @current_teams_categories = @current_teams_items.map{|i| i.category}
    end
  end
end
