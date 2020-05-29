class AttachmentsController < InheritedResources::Base

  private

    def attachment_params
      params.require(:attachment).permit()
    end
end

