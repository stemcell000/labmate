class Attachment < ApplicationRecord
 mount_uploader :attachment, AttachmentUploader
 
 belongs_to :item
 
 #La ligne suivante permet de supprimer l'enregistrement de Clone_batch_attachment lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |attachment| attachment.destroy if item_attachment.attachment.blank? }
 
end
