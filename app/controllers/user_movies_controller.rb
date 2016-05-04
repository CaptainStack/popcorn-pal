class UserMoviesController < ApplicationController
  def add_to_watchlist
    @user_movie = UserMovie.find_by(user_id: user_movie_params[:user_id], movie_id: user_movie_params[:movie_id]) || UserMovie.new(user_movie_params)
    @user_movie.on_watchlist = true
    @user_movie.save!
    redirect_to(:back)
  end
  
  def remove_from_watchlist
    if @user_movie = UserMovie.find_by(user_id: user_movie_params[:user_id], movie_id: user_movie_params[:movie_id])
      @user_movie.on_watchlist = false
      @user_movie.save!
      redirect_to(:back)
    else
      flash[:notice] = "That movie isn't currently on your watchlist"
    end
  end
  
  private
  
    def user_movie_params # this will raise, TODO: Handle exceptions
      params[:user_movie] = { user_id: params[:user_id], movie_id: params[:movie_id], on_watchlist: :on_watchlist } if !params[:user_movie]
      params.require(:user_movie).permit(:user_id, :movie_id, :on_watchlist)
    end
end
