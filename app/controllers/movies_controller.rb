class MoviesController < ApplicationController
  before_action :set_api_key, only: [:show, :create, :tmdb_query]
  def index
  end
  
  def create
    tmdb_result = Tmdb::Movie.detail(params[:id])
    params = filter_params(tmdb_result)
    @movie = Movie.new(params)
    @movie.save!
    render 'show'
  end
  
  def show
    @movie = find_or_create_by_id(params[:id])
  end
  
  def tmdb_query
    render json: Tmdb::Movie.find(params[:query])
  end
  
  private
    def set_api_key
      Tmdb::Api.key(ENV['TMDB_API_KEY'])
    end
    
    def movie_params
      params.require(:movie).permit(:content, :picture)
    end
    
    def filter_params(params)
      permitted = Set.new %w(
        id
        imdb_id 
        title 
        release_date 
        overview 
        poster_path 
        backdrop_path 
        popularity 
        adult
      )
      params.select do 
        |k, v| permitted.include?(k)
      end
    end
    
    def find_or_create_by_id(id)
      if Movie.exists?(id)
        Movie.find(id)
      else
        create
      end
    end
end
