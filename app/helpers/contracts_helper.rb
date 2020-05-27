module ContractsHelper
  
  def set_contract_row_color(contract)
    color=""
    if contract.end_date < Date.today
      color = "bg bg-warning"
    elsif contract.tender == true
      color = "bg bg-primary text-white"
    end
    return color
  end
end
