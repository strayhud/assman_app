class Asset < ActiveRecord::Base
  attr_accessible :album_id, :photo, :photo_id
  belongs_to :album
  has_attached_file :photo, 
        :styles => { :thumb => "100x100", :small => "400x400", :medium => "800x800", :large => "1200x1200"  },
        :path => ":rails_root/public/system/:attachment/:album_id/:style/:filename",
        :url  => "/system/:attachment/:album_id/:style/:filename"
end
