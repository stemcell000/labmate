module ContractsHelper
  
  def set_contract_row_color(contract)
    color=""
    if contract.end_date < Date.today
      color = "light-grey"
    elsif contract.tender == true
      color = "green"
    end
    return color
  end
end
