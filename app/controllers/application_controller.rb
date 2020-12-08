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
  
  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end
  
  def configure_permitted_parameters
    added_attrs = [:username, :email, :encrypted_password, :firstname, :lastname, :location_id, :recap, :role, :password, :password_confirmation, :remember_me, {team_ids: []}, {position_ids: []}, teams_attributes:[:id, :name, :acronym], positions_attributes:[:id, :name]]
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
          flash.now[:error] = "<small>#{t('items.flash_orphans')} #{t('items.orphan_item', count: n_orphans)} : #{orphans_bc.to_sentence}</small>".html_safe
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
           condition = tender.categories & @current_teams_categories
            unless condition.empty?
              flash.now[:success] = t('items.flash_tender', category:tender.categories.pluck(:name).to_sentence.humanize)
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
  
  # path for redirection after user sign_in, depending on user role
  def after_sign_in_path_for(user)
   user.role == "superadmin"? admin_dashboard_path : root_path 
  end

  def massive_files_attachment(folder_name, object_list, attachmentModel)
      begin
      #Starting values
        origin = File.join(Rails.root, folder_name)
        Dir.chdir(origin)
        files_names = Dir.entries(".")
      #Loop over the items
        object_list.each do |object|
          if files_names.include? object.barcode
            puts("Object has folder.")
            object_dir = File.join(origin, object.barcode)
            Dir.chdir(object_dir)
            Dir.glob("*").each do |file_name|
              puts("files selection.")
              src = File.join(object_dir, file_name)
              object_attachment = attachmentModel.new()
              puts("attachement creation.")
              object_attachment.attachment = File.new(src)
              puts("file saving.")
              object_attachment.save
              object.item_attachments << object_attachment
            end
          end
        end
    end
      rescue Errno::ENOENT
      puts "Unkown folder."  
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
