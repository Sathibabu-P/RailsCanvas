class Blog < ActiveRecord::Base
	has_attached_file :image
	belongs_to :user
	has_many :blog_photos, :dependent => :destroy
	validates :title, :description,  presence: true
end
