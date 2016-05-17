module Friendship_Helpers
  extend ActiveSupport::Concern
  
  def friend(friendship)
    if self == friendship.requester
      friendship.recipient
    elsif self == friendship.recipient
      friendship.requester
    else
      nil
    end
  end
  
  def find_friendship_by_friend_id(friend_id)
    self.all_friendships.where("user_id = ? or friend_id = ?", friend_id, friend_id).first
  end
  
  def is_friends_with?(other_user)
    !self.friendships.where("user_id = ? or friend_id = ?", self.id, self.id).empty?
  end
  
  def is_pending_friendship_with?(other_user)
    !self.all_pending_requests.where("user_id = ? or friend_id = ?", self.id, self.id).empty?
  end
  
  def all_friendships
    # Update when migrated to Rails 5 to use '.or.where()'
    Friendship.where("user_id = ? or friend_id = ?", self.id, self.id)
  end

  def friendships
    self.all_friendships.where(is_pending: false)
  end

  def all_pending_requests
    self.all_friendships.where(is_pending: true)
  end

  def outgoing_friend_requests
    self.all_friendships.where("user_id = ? and is_pending = ?", self.id, true)
  end

  def incoming_friend_requests
    self.all_friendships.where("friend_id = ? and is_pending = ?", self.id, true)
  end
end
