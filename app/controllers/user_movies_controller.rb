class UserMoviesController < ApplicationController
  def create
    @user_movie = UserMovie.new(user_movie_params)
    @user_movie.save!
    redirect_to(:back)
  end
  
  def update
    if @user_movie = UserMovie.find_by(user_id: user_movie_params[:user_id], movie_id: user_movie_params[:movie_id])
      @user_movie.update_attributes(user_movie_params)
      redirect_to(:back)
    else
      create
    end
  end
  
  private
  
    def user_movie_params
      params.require(:user_movie).permit(:user_id, :movie_id, :on_watchlist)
    end
end
