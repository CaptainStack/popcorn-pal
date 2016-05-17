class Friendship < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: "user_id"
  belongs_to :recipient, class_name:  'User', foreign_key: "friend_id"
  
  def friend(current_user)
    if current_user == self.requester
      self.recipient
    elsif current_user == self.recipient
      self.requester
    else
      nil
    end
  end
end
