class FriendshipsController < ApplicationController

  # POST /friendships
  # POST /friendships.json
  def create
    # @friendship = Friendship.new(friendship_params)
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to user_friends_url, notice: 'Friend request was sent successfully' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: 'Unable to sent friend request.', status: :unprocessable_entity }
      end
    end
  end



  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find_by_id(params[:id])
    @friendship = current_user.inverse_friendships.find_by_id(params[:id]) unless @friendship.present?    
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to user_friend_url(current_user), notice: 'Friendship was successfully Removed.' }
      format.json { head :no_content }
    end
  end

  private
 

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:user_id,:friend_id)
    end
end
