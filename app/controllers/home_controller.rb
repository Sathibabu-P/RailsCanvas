class HomeController < ApplicationController
  
  respond_to :html, :json
  def index  	
  end

  def create  
  	@user_shape = UserShape.new
  	@shape = Shape.where(:name => params[:shape]).first	
  	if @shape.present?
  		@user_shape.user = current_user
  		@user_shape.shape = @shape
      @user_shape.x = params[:x]
      @user_shape.y = params[:y]
  		@user_shape.save!
  	end
  	render :json => true
  end


  def update
    @user_shape = UserShape.find(params[:id])
    if @user_shape.present?
      @user_shape.x = params[:x]
      @user_shape.y = params[:y]
      @user_shape.w = params[:w]
      @user_shape.h = params[:h]
      @user_shape.r = params[:r]
      @user_shape.save!
    end
    render :json => true
  end


  def usershapes
  	  @user_shapes = current_user.user_shapes
	    if @user_shapes 
        render json: @user_shapes.as_json(include: { shape: { only: :name} }), status: :ok
      else
        render :json => false
      end
  end


 # def user_shape_params
 # 	params.require(:user_shape).permit(:shape_id,:user_id,:width,:height,:radius,:text,:data)
 # end
 
end
