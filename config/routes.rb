Rails.application.routes.draw do
  get 'home/index'
  # resources :users

  root to: "home#index"
  get 'sign_up', to: 'users#new', as: :sign_up
  post 'sign_up', to: 'users#create'

  get 'sign_in', to: 'sessions#new', as: :sign_in
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
