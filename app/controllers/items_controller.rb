class ItemsController < InheritedResources::Base
  
  load_and_authorize_resource
  before_action :set_item, only: [:edit,:destroy, :update, :set_item_parameters, :print_label, :show, :format_attributes, :printable_show]
  before_action :set_item_parameters, only: [:new, :edit, :show, :printable_show]
  before_action :set_option, only: [:index]
  before_action :format_attributes, only: [:show, :printable_show]
  
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  def index
    check_for_orphans
    check_for_tenders
    @superadmin = Team.where(name: "system admin")
    @currencies = Currency.all
    @users = User.all.where.not(role: 'superadmin').order(lastname: "asc").map{ |obj| [(obj['firstname']+" "+obj['lastname']), obj['id']] }
    @categories = Category.all.order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    @owners = Owner.all.order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    @locations = Location.all.order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    @providers = Provider.all.order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    @brands = Brand.all.order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    unless ['superadmin','administartor', 'inventory_manager'].include? current_user.role
      @statuses = Status.where.not(id: 5).order(name: "asc").uniq.map{|obj| [obj['name'], obj['id']]}
    else
      @statuses=Status.all.order(name: "asc").uniq.map{|obj| [obj['name'].capitalize, obj['id']]}
    end
    @teams = Team.all.order(name: "asc").uniq.map{ |obj| [(obj['name']), obj['id']] }
    @current_user_teams = current_user.teams.order(name: "asc").uniq.map{ |obj| [(obj['name']), obj['id']] }
    #"between search": recherche dans un range de dates
      
      #Formattage des dates
      start_time = params[:created_at_gteq].to_date rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:created_at_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
      
      start_install_time = params[:installation_date_gteq].todate rescue Date.current
      start_install_time = start_install_time.beginning_of_day # sets to 00:00:00
      end_install_time = params[:installation_date_lteq].to_date rescue Date.current
      end_install_time = end_install_time.end_of_day # sets to 23:59:59
      
      @q = Item.ransack(params[:q])
      @items = @q.result.includes([ :teams, :location, :users, :category, :status, :owner, :provider, :brand, :currency ])
   
    if @option.display_all
      @items = @items.joins(:items_teams).where(:items_teams => {team_id: current_user.team_ids})
    end
    
    unless ['superadmin', 'administrator'].include? current_user.role
      @items = @items.joins(:status).where.not(:status=>{name: 'removed'})
    end
     
      #
      #Config de l'affichage des résultats.
      @items = smart_listing_create(:items, @items, partial: "items/smart_listing/listing",
                                                  default_sort: {name: "asc"},
                                                  page_sizes: [ 10, 20, 30, 50, 100])
  end
  
  def select_contract
    team_ids = current_user.ids
    contracts = Contract.belongs_to_teams(teams_ids)
  end
  
  def print_label
      require 'net/ftp'
      ftp = Net::FTP.open('134.157.174.75')
      ftp.login
      filepath = Rails.root+"public/mylabel.prn"
      location_name = @item.location.nil? ? "unknown" : @item.location.name
      #
      File.open(filepath, 'r+') do |file|
        lines = file.each_line.to_a
        lines[12] = "\t\t\t\t\t\t\t^FH\\^FD"+@item.barcode+"^FS\n"
        lines[13] = "\t\t\t\t\t\t\t^FT329,394^A@N,100,101,TT0003M_^FH\\^CI17^F8^FD"+@item.barcode+"^FS^CI0\n"
        lines[14] = "\t\t\t\t\t\t\t^FT329,496^A@N,46,42,TT0003M_^FH\\^CI17^F8^FD"+location_name+"L2^FS^CI0\n"
        file.rewind
        file.write(lines.join)
      end
      #
      ftp.puttextfile(filepath)
      #render action: :edit
  end
  
  def new
    @item = Item.new
  end
  
  def edit
    @contracts = Contract.belongs_to_teams(current_user.teams.ids).uniq
    @events = @item.occurances
  end
  
  def update
    @item.update_attributes(item_params)
    if @item.valid?
      flash.keep[:success] = "Task completed!"
      @item.generate_recap
      redirect_to item_path(@item)
      return
    else
      render :action => :edit
    end
  end
  
  def show
   respond_to do |format|
     format.html { render :show }
     
     format.pdf do
        pdf = ItemPdf.new(@item, current_user, Organization.last)
        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end
  
  def generate_tracking_sheet
     respond_to do |format|     
     format.pdf do
        pdft = ItemTrackPdf.new(@item, Organization.last)
        send_data pdft.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
      end
  end
  
  def remove
    @item.status_id = 5
    @item.save!
  end
  
  def create
    @item = Item.create(item_params)
    if @item.valid?
      @item.update_columns(barcode: Organization.last.acronym+@item.id.to_s)
      @item.generate_recap
      flash.keep[:success] = "Task completed!"
      redirect_to item_path(@item)
    else
      render :action => :new
    end
  end
  
  protected
  
   def formatted_number(int, digit)
    digit = digit.to_s
    format("%0"+ digit + "d" , int)
   end
 
  private
  def set_item
    @item = Item.find(params[:id])
  end
  
  def set_item_parameters
    
    @categories = Category.all
    @statuses = Status.all.order(name: "asc")
    @owners = Owner.all
    @locations = Location.all
    @providers = Provider.all.order(name: "asc")
    @brands = Brand.all.order(name: "asc")
    @currencies = Currency.all.order(name: "asc")
    
     @user_status = current_user.role.include?("superadmin" || "administrator")
     
     unless @user_status
            @teams = @item.teams
           if params[:action] == "new"
               @users = User.by_teams(current_user.team_ids)
           elsif params[:action] == "edit"
             @users = User.by_teams(@item.team_ids)
            end
      else
        @teams = Team.all
        @users = User.all
      end
    @teams =  @teams.order(name: "asc").map{ |obj| [obj['name'], obj['id']] }
    @users = @users.order(lastname: "asc").map{ |obj| [(obj['firstname']+" "+obj['lastname']), obj['id']] }
      
    org_acronym = !Organization.all.nil? ? "UKN" : Organization.first.acronym
    number = Item.all.nil? ?  Item.last.id : 1 
    @barcode= org_acronym+formatted_number(number, 5)
  end
  
  def set_option
    @option = current_user.options.first
  end
  
  def format_attributes
    @barcode = @item.barcode.nil? ? '-' : @item.barcode
    @name = @item.name.nil? ? '-' : @item.name
    @status_name = @item.status.nil? ? '-' : @item.status.name
    @full_name = @item.users.nil? ? 'None' : @item.users.map{|u| "<a href = 'mailto:#{u.email}'>#{u.full_name}</a>".html_safe}.to_sentence
    @address = @item.users.nil? ? '' : @item.users.map{|u| u.email}
    @team_name = @item.teams.nil? ? '-' : @item.teams.map{|t| t.name}.to_sentence
    @location_name = @item.location.nil? ? '-' : @item.location.name
    @category_name = @item.category.nil? ? '-' : @item.category.name
    @installation_date = @item.installation_date.nil? ? '-' : @item.installation_date.strftime('%b %e, %Y')
    @created_at = @item.created_at.nil? ? '-' : @item.created_at.strftime('%b %e, %Y')
    @serial_number = @item.serial_number.nil? ? '-': @item.serial_number
    @provider_name = @item.provider.nil? ? '-' : @item.provider.name
    @brand_name = @item.brand.blank? ? '-' : @item.brand.name
    @owner_name = @item.owner.blank? ? '-' : @item.owner.name
    @owner_inventory = @item.owner_inventory.blank? ? '-' : @item.owner_inventory
    @price = @item.price == 0 ? '-' : @item.price.to_s
    @currency_price_name = @item.price == 0 ? '' : (@item.currency.name.nil? ? '':@item.currency.name)
    @currency_residue_name = @item.residue == 0 ? '' : (@item.currency.name.nil? ? '':@item.currency.name)
    @residue = @item.residue .nil? ? '-' : @item.residue.to_s
    @folder_number = @item.folder.blank? ? '-' : @item.folder
    @order = @item.order.nil? ? '-' : @item.order
    @order_note = @item.order_note.nil? ? '-': @item.order_note
    @invoice = @item.invoice.nil? ? '-': @item.invoice
    @invoice_note = @item.invoice_note.nil? ? '-': @item.invoice_note
    @comment = @item.comment.blank? ? '-' : @item.comment
    @donation = @item.donation.nil? ? '-' : to_yesorno(@item.donation)
    @contract = @item.contracts.where('end_date <=?', DateTime.now).last.nil? ? '-' : @item.contracts.where('end_date <=?', DateTime.now).last
  end
  
  def to_yesorno(boolean)
    if boolean == 'yes'
    return 'yes'
    else
    return 'no'
    end
  end
  
  def item_params
      params.require(:item).permit(
      :id, :barcode, :name, :serial_number, :owner_inventory, :installation_date, :price, :residue, :interval, :duration, :amortization, :folder, :registered, :order, :order_note,
      :invoice, :invoice_note, :comment, :status, :deleted, :date_of_deletion, :created_at, :update_at, :currency, :location_id, :category_id, :provider_id,
      :brand_id, :owner_id, :donation,
      
      :attachments_attributes =>[:id, :item_id, :doc_type, :name, :attachment, :_destroy],
      
      user_ids: [], team_ids: [], teams_attributes: [:id, :name], locations_attributes: [:id, :name], users_attributes: [:id, :firstname, :lastname, :email, :full_name, :display],
      category_attributes: [:id, :name, :acronym], provider_attributes: [:id, :name ], brand_attributes: [:id, :name], owners_attributes: [:id, :name],
      occurances_attributes: [:id, :name, :done, :item_id, :comment, :_destroy,
      days_attributes: [:id, :date, :_destroy]]
      ) 
    end

end

