module ItemsHelper
  def set_item_row_color(current_user, current_item)
    color=""
    if !(current_user.teams.ids & current_item.teams.ids).empty?
      if !current_user.options.first.display_all
        color =  "bg bg-success"
      end
    elsif current_item.teams.empty?
      color = "bg bg-warning"
    end
    return color
  end
  
  def set_user_icon_color(current_item)
    color=""
    if current_item.item_users.empty?
      color = "bg bg-danger"
    end
  end
  
  
end
