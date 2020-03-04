class ItemAttachment < ApplicationRecord
 mount_uploader :attachment, ItemAttachmentUploader
 
 belongs_to :item
 
 #La ligne suivante permet de supprimer l'enregistrement de Clone_batch_attachment lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |item_attachment| item_attachment.destroy if item_attachment.attachment.blank? }
 
end
