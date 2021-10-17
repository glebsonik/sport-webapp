# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  # TODO: transform to resources
  put 'articles/update'
  post 'articles/create'
  get 'articles/:key_name', to: 'articles#new', as: :new_article
  get 'create_articles/create'

  get 'admin_categories/:key_name', to: 'admin_categories#show', as: :admin_categories

  get 'admin_home/index', as: :admin_home
  get 'email_confirmation/index', as: :confirm_email
  get 'home/index'

  root to: "home#index"
  get 'sign_up', to: 'users#new', as: :sign_up
  post 'sign_up', to: 'users#create'

  get 'sign_in', to: 'sessions#new', as: :sign_in
  post 'sign_in', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: :sign_out

  get 'email/preconfirmation', to: 'email_confirmation#preconfirmation', as: :preconfirmation
  get 'email/resend', to: 'email_confirmation#resend_email', as: :resend_email

  namespace :api do
    namespace :v1 do
      get 'categories/categories'
      get 'categories/translated'
      get 'categories/by_id'
      get 'categories/translated_by_id'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'conferences/conferences'
      get 'conferences/translated'
      get 'conferences/by_id'
      get 'conferences/translated_by_id'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'teams/teams'
      get 'teams/by_id'
    end
  end

end
