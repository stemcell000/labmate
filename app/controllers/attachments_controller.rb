class AttachmentsController < InheritedResources::Base

  private

    def attachment_params
      params.require(:attachment).permit(:id, :item_id, :contract_id, :name, :attachment, :remove_attachment, :doc_type, :_destroy)
    end

end
