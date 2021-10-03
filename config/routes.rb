# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get 'email_confirmation/show', as: :confirm_email
  get 'home/index'

  root to: "home#index"
  get 'sign_up', to: 'users#new', as: :sign_up
  post 'sign_up', to: 'users#create'

  get 'sign_in', to: 'sessions#new', as: :sign_in
  post 'sign_in', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: :sign_out

  get 'email/resend_preview', to: 'email_confirmation#resend_preview', as: :resend_preview
  get 'email/resend', to: 'email_confirmation#resend_email', as: :resend_email
end
