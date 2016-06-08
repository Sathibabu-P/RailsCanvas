class HomeController < ApplicationController
  layout 'home'
  
  def index
  	@blogs = Blog.where(:publish => true).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  end


  def show
  	@blog = Blog.find(params[:id])
  end
end
