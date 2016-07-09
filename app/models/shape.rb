class Shape < ActiveRecord::Base

	has_many :user_shapes
    has_many :users, through: :user_shapes

    
end
