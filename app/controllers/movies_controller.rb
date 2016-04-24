class MoviesController < ApplicationController
  before_action :set_api_key, only: [:show, :tmdb_query]
  def index
  end
  
  def show
    tmdb_result = Tmdb::Movie.detail(params[:id])
    movie = {id: tmdb_result['id'], title: tmdb_result['title'], 
      release_date: tmdb_result['release_date'], poster_path: tmdb_result['poster_path']}
    @movie = Movie.new(movie)
    render 'show'
  end
  
  def tmdb_query
    render json: Tmdb::Movie.find(params[:query])
  end
  
  private
    def set_api_key
      Tmdb::Api.key(ENV['TMDB_API_KEY'])
    end
end
