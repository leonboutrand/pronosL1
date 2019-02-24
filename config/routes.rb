Rails.application.routes.draw do
  resources :articles
  devise_for :users

  get 'live', to: 'pages#live', as: :live
  get 'pronos', to: 'pages#pronos', as: :pronos
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
