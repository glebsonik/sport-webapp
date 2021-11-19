# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  # TODO: transform to resources
  put 'articles/publish/:id', to: 'articles#publish', as: :publish_article
  put 'articles/unpublish/:id', to: 'articles#unpublish', as: :unpublish_article
  put 'articles/update'

  delete 'articles/:id', to: 'articles#destroy', as: :delete_article
  post 'articles/create'
  get 'articles/:key', to: 'articles#new', as: :new_article
  get 'create_articles/create'

  get 'admin_categories/:key', to: 'admin_categories#show', as: :admin_categories

  get 'admin_home/index', as: :admin_home
  get 'email_confirmation/show', as: :confirm_email
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
      get 'teams', to: 'teams#index'
    end
  end

end
