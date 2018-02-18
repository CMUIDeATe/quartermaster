Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:sessions]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    if Rails.env.production? || Rails.env.staging?
      get 'login' => 'users/omniauth_callbacks#passthru', as: :new_user_session
    else
      get 'login' => 'devise/sessions#new', as: :new_user_session
    end
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  root 'welcome#index'

  resources :items
  resources :lendable_items, controller: 'items'
  resources :saleable_items, controller: 'items'

  resources :print_requests, path: 'print' do
    member do
      get 'confirm'
      post 'confirm', to: 'print_requests#record_confirmation'
      post 'set_status'
    end
    resources :print_request_actions
  end

  # Legacy lending system from Zoho
  get '/lending', to: 'legacy_lending#index'
  get '/lending/lend', to: 'legacy_lending#lend'
  get '/lending/student_purchase', to: 'legacy_lending#student_purchase'
  get '/lending/external_purchase', to: 'legacy_lending#external_purchase'
  get '/lending/course_purchase', to: 'legacy_lending#course_purchase'
  get '/lending/pc_cart', to: 'legacy_lending#pc_cart'
  get '/lending/schedule', to: 'legacy_lending#schedule'
  get '/lending/nvbots', to: 'legacy_lending#nvbots'

  post '/lending/card_input', to: 'legacy_lending#card_input'

end
