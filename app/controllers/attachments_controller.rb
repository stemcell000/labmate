class AttachmentsController < InheritedResources::Base

  private

    def attachment_params
      params.require(:attachment).permit(:name, :doc_type, :attachment, :item_id)
    end
end

