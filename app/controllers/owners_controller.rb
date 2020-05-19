class OwnersController < InheritedResources::Base
  private

    def owner_params
      params.require(:owner).permit(:name)
    end
end

