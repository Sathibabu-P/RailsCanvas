class AddAttachmentPhotoToBlogPhotos < ActiveRecord::Migration
  def self.up
    change_table :blog_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :blog_photos, :photo
  end
end
