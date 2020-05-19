class BuildingController < ApplicationController
  
    private

    def building_params
      params.require(:building).permit(:name, :organization_id, :address, :zipcode, :city, :country)
    end
end
