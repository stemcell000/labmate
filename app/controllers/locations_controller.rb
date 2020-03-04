class LocationsController < InheritedResources::Base

  private

    def location_params
      params.require(:location).permit(:name, :building_id, :floor_id)
    end
end

