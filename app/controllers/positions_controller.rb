class PositionsController < InheritedResources::Base
load_and_authorize_resource
  private

    def position_params
      params.require(:position).permit(:name, :acronym)
    end
end

