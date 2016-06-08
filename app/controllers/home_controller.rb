class HomeController < ApplicationController
  layout 'home'
  
  def index
  	@blogs = Blog.where(:publish => true).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  end


  def show
  	@blog = Blog.find(params[:id])
  	# get all current user friends
  	@friends = current_user.friendships.where(:status => true).map { |friendship|  friendship.friend} 
    @friends << current_user.inverse_friendships.where(:status => true).map { |friendship|  friendship.user}
   	@friends = @friends.flatten
  end
end
