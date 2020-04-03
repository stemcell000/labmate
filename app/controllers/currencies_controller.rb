class CurrenciesController < ApplicationController
  
 private
     def currency_params
      params.require(:currency).permit(:name)
    end
end
