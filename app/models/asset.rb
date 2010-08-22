class Asset < ActiveRecord::Base
  attr_accessible :album_id, :photo, :photo_id
  belongs_to :album
  has_attached_file :photo, 
        :styles => { :thumb => "100x100", :small => "400x400", 
                     :medium => "800x800", :large => "1200x1200"  },
        :path => ":rails_root/public/system/:attachment/:album_id/:style/:filename",
        :url  => "/system/:attachment/:album_id/:style/:filename"
  before_post_process :transliterate_file_name
        
private
  
  def transliterate_file_name
    extension = File.extname(photo_file_name).gsub(/^\.+/, '')
    filename = photo_file_name.gsub(/\.#{extension}$/, '')
    self.photo.instance_write(:file_name,
          "#{transliterate(filename)}.#{transliterate(extension)}")
  end
        
  def transliterate(str)
    # Based on permalink_fu by Rick Olsen
 
    # Escape str by transliterating to UTF-8 with Iconv
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
 
    # Downcase string
    s.downcase!
 
    # Remove apostrophes so isn't changes to isnt
    s.gsub!(/'/, '')
 
    # Replace any non-letter or non-number character with a space
    s.gsub!(/[^A-Za-z0-9]+/, ' ')
 
    # Remove spaces from beginning and end of string
    s.strip!
 
    # Replace groups of spaces with single hyphen
    s.gsub!(/\ +/, '-')
 
    return s
  end
end
