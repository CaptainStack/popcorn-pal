Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'movies/tmdb_query/:query' => 'movies#tmdb_query'
  resources :movies
  post 'movies/:id' => 'movies#create'
  root 'home#index'
end
