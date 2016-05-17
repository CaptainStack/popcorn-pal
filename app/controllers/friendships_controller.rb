class FriendshipsController < ApplicationController
  before_action :can_delete, only: :destroy
  before_action :can_accept, only: :update
  before_action :can_add, only: :create

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.save!
    redirect_to(:back)
  end

  def update
    if @friendship
      @friendship.is_pending = false
      @friendship.save!
      redirect_to(:back)
    else
      redirect_to root_url
    end
  end

  def destroy
    @friendship.destroy
    redirect_to(:back)
  end

  private
    def friendship_params
      params[:user_id] = current_user.id
      params[:friendship] = params;
      params.require(:friendship).permit(:user_id, :friend_id, :is_pending)
    end

    def can_delete
      @friendship = current_user.find_friendship_by_friend_id(params[:friend_id])
      redirect_to root_url if @friendship.nil?
    end

    def can_accept
      @friendship = current_user.incoming_friend_requests.where("user_id = ? and friend_id = ?", params[:friend_id], current_user.id).first
      redirect_to root_url if @friendship.nil?
    end
    
    def can_add
      if params[:friend_id].to_i == current_user.id
        flash[:notice] = "You cannot friend yourself"
        redirect_to(:back)
      elsif !current_user.find_friendship_by_friend_id(params[:friend_id]).nil?
        flash[:notice] = "You're already friends with that that user"
        redirect_to(:back)
      end
    end
end
