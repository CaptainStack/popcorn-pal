Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'movies/tmdb_query/:query' => 'movies#tmdb_query'
  resources :movies
  root 'home#index'
end
