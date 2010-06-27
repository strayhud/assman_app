Paperclip::Attachment.interpolations[:album_id] = proc do |attachment, style|
  attachment.instance.album_id # or whatever you've named your User's login/username/etc. attribute
end
