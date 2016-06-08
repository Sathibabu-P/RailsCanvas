class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]  

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = current_user.blogs
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
  
    @blog =  current_user.blogs.build(blog_params)
    respond_to do |format|
      if @blog.save  
        # upload photos
        upload_photos
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        # upload photos
        upload_photos
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def destroy_photo
    @photo = BlogPhoto.find(params[:id])
    @photo.destroy if  @photo.present?
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Photo was successfully destroyed.' }
      format.js
    end
  end


  def share
    @blog = Blog.find(params[:blog_id])
    if @blog.present? 

       reciepents = current_user.friendships.where(:status => true).map {|friendship| friendship.friend.email}    
       reciepents << current_user.inverse_friendships.where(:status => true).map {|friend| friend.user.email}  
   
      reciepents.flatten.each do |user|        
         BlogMailer.share_blog(@blog,user).deliver_now 
      end 

      respond_to do |format|
        format.html { redirect_to request.referrer, notice: 'Share Blog successfully..' }
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :description, :publish)
    end


    # upload photos if photos are present
    def upload_photos
      # check for photos and save
       if params[:photos]         
        params[:photos].each { |image|
          @blog.blog_photos.create(photo: image)
        }
       end
    end
end
