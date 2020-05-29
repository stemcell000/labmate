class UserAttachmentsController < InheritedResources::Base

  private

    def user_attachment_params
      params.require(:user_attachment).permit()
    end
end

