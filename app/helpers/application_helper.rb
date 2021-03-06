module ApplicationHelper

def bootstrap_class_for flash_type
  { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
end
  
  def formatted_number(int, digit)
   digit = digit.to_s
    format "%0"+digit+"d" , int
  end
  
  def current_class?(test_path)
    return 'active' if request.path == test_path
  end
  
  def simple_pluralize count, singular, plural=nil
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end
  
  #Current page helper
  def cp(path)
   if current_page?(path)
    myclass= " nav-item active"
   else
     myclass="nav-item"
    end
    return myclass
 end 
  
end
