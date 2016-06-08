class UsersController < ApplicationController
  def index  
  	  friends = [current_user.id] 
  	  friends << current_user.friendships.map(&:friend_id)
  	  friends << current_user.inverse_friends.map(&:id)
  	  puts "==================#{friends.flatten}"
  	  @users = User.where('id NOT IN (?)',friends.flatten)
  end

  def show
  	@user = current_user
  end


  def accept_request
  	@friend = Friendship.find_by_id(params[:user_friend_id])
  	# @friend = current_user.inverse_friendships.where(:user_id => params[:user_friend_id]).first  
  	respond_to do |format|
	  	if @friend.present?
	  		 # @friend.friendships.where(:friend_id => current_user.id).first.update_attributes(:status => true)
	  		 @friend.update_attributes(:status => true)
	  		 format.html { redirect_to :back, notice: 'Friend was successfully Added.' }
	         format.json { render :show, status: :created, location: @friendship }
	    else
	        format.html { redirect_to :back }
	        format.json { render json: 'Unable to add friend.', status: :unprocessable_entity }
	    end 
	end
  end  	
  
end
