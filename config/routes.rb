Rails.application.routes.draw do
  get 'home/index'

  # SSO Routes
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  # movies
  get 'movies/tmdb_query/:query' => 'movies#tmdb_query'
  resources :movies
  post 'movies/:id' => 'movies#create'
  
  # user_movies. Watchlist routes
  post 'users/:id/watchlist' => 'user_movies#create'
  patch 'users/:id/watchlist' => 'user_movies#update'
  
  root 'home#index'
end