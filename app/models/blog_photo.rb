class BlogPhoto < ActiveRecord::Base
	belongs_to :blog
		
	has_attached_file :photo,
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"

	validates_attachment :photo,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
