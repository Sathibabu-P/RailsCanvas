class CreateBlogPhotos < ActiveRecord::Migration
  def change
    create_table :blog_photos do |t|
      t.references :blog
      t.timestamps null: false
    end
  end
end
