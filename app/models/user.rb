class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  include Omniauth_Helpers
  
  include Friendship_Helpers
  has_many :user_movies

  def watchlist
    self.user_movies.where(on_watchlist: true)
  end

  def has_seen?(movie)
    self.user_movies.where("movie_id = ? and seen = ?", movie.id, true).length > 0
  end
end
