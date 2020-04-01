module UsersHelper
def num_to_phone(num)
  "#{ num[0..1] } #{ num[2..3] } #{ num[4..5] } #{ num[6..7] } #{ num[8..9] }"
end

def invcolor(obj)
    if obj.role == "former_employee"
      "danger"
    end
  end

def role_set(name)
  case name
   when "superadmin"
     t('roles.superadmin')
   when "administrator"
     t('roles.administrator')
   when "HR_administrator"
     t('roles.hr_administrator')
   when "inventory_manager"
     t('roles.inventory_manager')
   when "team_leader"
     t('roles.team_leader')
   when "user"
     t('roles.user')
   when "former_employee"
     t('roles.former_employee')
   else
     t('role.unknown')
  end
  end
end