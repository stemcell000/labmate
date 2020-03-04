class OccurancesController < InheritedResources::Base

  private

    def occurance_params
      params.require(:occurance).permit(:item_id, :name, :comment, :done)
    end
end

