class MoviesController < ApplicationController
  before_action :set_api_key, only: [:show, :tmdb_query]
  def index
  end
  
  def show
    @movie = {}
    Tmdb::Api.key(ENV['TMDB_API_KEY'])
    movie = Tmdb::Movie.detail(params[:id])
    @movie["title"] = movie["title"]
    @movie["id"] = movie["tmdb_id"]
    @movie["release_date"] = Date.parse(movie["release_date"])
    @movie["poster_path"] = movie["poster_path"]
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
