class FriendshipsController < ApplicationController
  before_action :correct_user, only: :destroy
  
  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.save!
    redirect_to(:back)
  end
  
  def update 
  end
  
  def destroy
    @friendship.destroy
    redirect_to(:back)
  end
  
  private
    def friendship_params
      params[:friendship] = params;
      params.require(:friendship).permit(:friend_id, :is_pending)
    end
    
    def correct_user
      @friendship = current_user.friends.find_by(user_id: current_user.id, friend_id: params[:friend_id])
      redirect_to root_url if @friendship.nil?
    end
end