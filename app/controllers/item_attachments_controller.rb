class ItemAttachmentsController < InheritedResources::Base

  private

    def item_attachment_params
      params.require(:item_attachment).permit()
    end
end

