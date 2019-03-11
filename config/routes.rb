Rails.application.routes.draw do
  resources :articles do
    resources :comments, only: [:create]
  end
  devise_for :users

  get 'live', to: 'pages#live'
  get 'pronos', to: 'pages#pronos'
  get 'stats', to: 'pages#stats'

  resources :bets, only: [:create]
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
