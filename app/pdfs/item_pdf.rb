class ItemPdf

  include Prawn::View

  def initialize(item, current_user, organization)
    item = item
    att =  format_attributes(item)
    content(item, att, current_user, organization)
    font_setup
  end
  
  def font_setup
    font_families.update("NotoSans" => {
      :normal => "vendor/assets/fonts/NotoSans-Regular.ttf",
      :italic => "vendor/assets/fonts/NotoSans-Italic.ttf",
      :bold => "vendor/assets/fonts/NotoSans-Bold.ttf",
      :bold_italic => "vendor/assets/fonts/NotoSans-BoldItalid.ttf",
    })
    font "NotoSans"
  end

  def content(item, att, current_user, organization)
    title(att, organization)
    stroke_horizontal_rule
    info_block(att)
    stroke_horizontal_rule
    info_item(att)
    stroke_horizontal_rule
    info_admin(att)
    stroke_horizontal_rule
    if !(current_user.teams.ids & item.teams.ids).empty?
      info_price(att)
     stroke_horizontal_rule
    end
     y_position = cursor-20
     bounding_box([0, y_position], :width => 300, :height =>50) do
        transparent(0.0) { stroke_bounds }
    pad_bottom(5) { text 'Maintenance : '+ att['contract'] }
    end
    stroke_horizontal_rule
     y_position = cursor-20
     bounding_box([0, y_position], :width => 300, :height =>70) do
        transparent(0.0) { stroke_bounds }
    pad_bottom(5) { text 'Comment: '+ att['comment'] }
    end
  end
  
  def title(att, organization)
     y_position = cursor
     bounding_box([0, y_position], :width => 300, :height => 20) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(10) { text organization.name }
      end
    y_position = cursor-20
     bounding_box([0, y_position], :width => 300, :height => 30) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(10) { text att['name'] }
      end
      bounding_box([450, y_position], :width => 100, :height => 30) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(10) { text att['barcode'] }
      end
  end
  
  def info_block(att)
    y_position = cursor-20
     bounding_box([0, y_position], :width => 350, :height =>150) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(5) { text 'Teams : '+ att['team_name'] }
           pad_bottom(5) { text 'Serial Number : '+ att['serial_number'] }
           pad_bottom(5) { text 'Location : '+ att['location_name'] }
           pad_bottom(5) { text 'Contact : '+ att['full_name'] }
           pad_bottom(5) { text 'Location : '+ att['location_name'] }
           pad_bottom(5) { text 'Installation on : '+ att['installation_date'] }
      end
  end
  
  def info_item(att)
    y_position = cursor-20
     bounding_box([0, y_position], :width => 400, :height =>100) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(5) { text 'Provider : '+ att['provider_name'] }
           pad_bottom(5) { text 'Brand : '+ att['brand_name'] }
           pad_bottom(5) { text 'Category : '+ att['category_name'] }
           pad_bottom(5) { text 'Status : '+ att['status_name'] }
      end
  end
  
  def info_admin(att)
    y_position = cursor-20
     bounding_box([0, y_position], :width => 400, :height =>70) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(5) { text 'Administrative owner : '+ att['owner_name'] }
           pad_bottom(5) { text 'Inventory number : '+ att['owner_inventory'] }
           pad_bottom(5) { text 'Folder : '+ att['folder_number'] }
      end
  end

  def info_price(att)
    y_position = cursor-20
     bounding_box([0, y_position], :width => 400, :height =>70) do
        transparent(0.0) { stroke_bounds }
           pad_bottom(5) { text 'Price : '+ att['price']+' '+att['currency_price_name'] }
           pad_bottom(5) { text 'Residue : '+ att['residue']+' '+att['currency_residue_name'] }
           pad_bottom(5) { text 'Donation : '+ att['donation'] }
    end
  end
  
 def format_attributes(item)
    barcode = item.barcode.nil? ? '-' : item.barcode
    name = item.name.nil? ? '-' : item.name
    status_name = item.status.nil? ? '-' : item.status.name
    full_name = item.users.nil? ? 'None' : item.users.map{|u| "#{u.full_name} (#{u.email}, #{u.tel1})"}.to_sentence
    address = item.users.nil? ? '' : item.users.map{|u| u.email}
    team_name = item.teams.nil? ? '-' : item.teams.map{|t| t.name}.to_sentence
    location_name = item.location.nil? ? '-' : item.location.name
    category_name = item.category.nil? ? '-' : item.category.name
    installation_date = item.installation_date.nil? ? '-' : item.installation_date.strftime('%b %e, %Y')
    created_at = item.created_at.nil? ? '-' : item.created_at.strftime('%b %e, %Y')
    serial_number = item.serial_number.nil? ? '-': item.serial_number
    provider_name = item.provider.nil? ? '-' : item.provider.name
    brand_name = item.brand.blank? ? '-' : item.brand.name
    owner_name = item.owner.blank? ? '-' : item.owner.name
    owner_inventory = item.owner_inventory.blank? ? '-' : item.owner_inventory
    price = item.price == 0 ? '-' : item.price.to_s
    currency_price_name = item.price == 0 ? '' : (item.currency.name.nil? ? '':item.currency.name)
    currency_residue_name = item.residue == 0 ? '' : (item.currency.name.nil? ? '':item.currency.name)
    residue = item.residue .nil? ? '-' : item.residue.to_s
    folder_number = item.folder.blank? ? '-' : item.folder
    order = item.order.nil? ? '-' : item.order
    order_note = item.order_note.nil? ? '-': item.order_note
    invoice = item.invoice.nil? ? '-': item.invoice
    invoice_note = item.invoice_note.nil? ? '-': item.invoice_note
    comment = item.comment.blank? ? '-' : item.comment
    donation = item.donation.nil? ? '-' : to_yesorno(item.donation)
    contract = item.contracts.where('end_date <=?', DateTime.now).last.nil? ? '-' : item.contracts.where('end_date <=?', DateTime.now).last
    
    hash = {'barcode'=> barcode, 'name'=> name, 'status'=> status_name, 'full_name'=>full_name, 'address'=> address,
            'team_name'=> team_name, 'location_name'=> location_name, 'category_name'=> category_name, 'installation_date'=>installation_date,
            'created_at'=>created_at, 'serial_number'=>serial_number, 'provider_name'=>provider_name, 'brand_name'=>brand_name, 
            'owner_name'=>owner_name,'owner_inventory'=>owner_inventory, 'price'=>price, 'currency_price_name'=>currency_price_name,
            'currency_residue_name'=>currency_residue_name,'residue'=>residue, 'folder_number'=>folder_number,'order'=>order,
            'order_note'=>order_note, 'invoice'=>invoice, 'invoice_note'=>invoice_note,'comment'=>comment,'donation'=>donation,
            'contract'=>contract, 'status_name'=>status_name
          }
 end
end