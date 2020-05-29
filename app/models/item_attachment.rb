class ItemAttachment < ActiveRecord::Base
 mount_uploader :attachment, AttachmentUploader
 
 belongs_to :item
 
 #La ligne suivante permet de supprimer l'enregistrement de l'attachement (attachment) lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |item_attachment| item_attachment.destroy if item_attachment.attachment.blank? }
end
