class Asset < ActiveRecord::Base
  attr_accessible :album_id, :photo
  belongs_to :album
  has_attached_file :photo, :styles => { :thumb => "100x100>", :medium => "1000x1000>"  },
        :path => ":rails_root/public/system/:attachment/:id/:style/:filename"
end
