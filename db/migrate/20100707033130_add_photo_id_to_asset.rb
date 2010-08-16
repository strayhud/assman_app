class AddPhotoIdToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :photo_id, :integer
  end

  def self.down
    remove_column :assets, :photo_id
  end
end
