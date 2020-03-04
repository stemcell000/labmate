class DaysController < InheritedResources::Base

  private

    def day_params
      params.require(:day).permit(:occurance_id, :date)
    end
end

