class PrimersController < InheritedResources::Base

  private

    def primer_params
      params.require(:primer).permit()
    end
end

