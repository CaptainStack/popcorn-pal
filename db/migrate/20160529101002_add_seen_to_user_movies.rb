class AddSeenToUserMovies < ActiveRecord::Migration
  def change
    add_column :user_movies, :seen, :boolean, default: false
  end
end
