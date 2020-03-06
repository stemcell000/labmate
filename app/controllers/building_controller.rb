class BuildingController < ApplicationController
  load_and_authorize_resource
  
    private

    def building_params
      params.require(:building).permit(:name, :organization_id, :address, :zipcode, :city, :country)
    end
end
