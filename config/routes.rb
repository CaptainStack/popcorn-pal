Rails.application.routes.draw do
  get 'home/index'

  # SSO Routes
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:show]
  
  # movies
  get 'movies/tmdb_query/:query' => 'movies#tmdb_query'
  resources :movies
  post 'movies/:id' => 'movies#create'
  
  # user_movies. Watchlist routes
  delete 'users/:user_id/watchlist/:movie_id' => 'user_movies#remove_from_watchlist'
  post 'users/:user_id/watchlist/:movie_id' => 'user_movies#add_to_watchlist'
  
  # friendships
  post 'users/friends/request/:friend_id' => 'friendships#create'
  patch 'users/friends/accept/:friend_id' => 'friendships#update'
  delete 'users/friends/request/:friend_id' => 'friendships#destroy'
  
  root 'home#index'
end
