class LocationsController < InheritedResources::Base
load_and_authorize_resource
  private

    def location_params
      params.require(:location).permit(:name, :building_id, :floor_id)
    end
end

