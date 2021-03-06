class Attachment < ActiveRecord::Base
 mount_uploader :attachment, AttachmentUploader
 
 belongs_to :contract
 
 #La ligne suivante permet de supprimer l'enregistrement de l'attachement (attachment) lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |attachment| attachment.destroy if attachment.attachment.blank? }

end
