class OwnersController < InheritedResources::Base
load_and_authorize_resource
  private

    def owner_params
      params.require(:owner).permit(:name)
    end
end

