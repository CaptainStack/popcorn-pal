class Movie < ActiveRecord::Base
  belongs_to :user_movies
end