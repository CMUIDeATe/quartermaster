Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:sessions]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    if Rails.env.production? || Rails.env.staging?
      get 'login' => 'users/omniauth_callbacks#shibboleth', as: :new_user_session
    else
      get 'login' => 'devise/sessions#new', as: :new_user_session
    end
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  root 'welcome#index'

  resources :items, :tags, :types
  resources :print_requests, path: 'print' do
    member do
      get 'confirm'
      post 'confirm', to: 'print_requests#record_confirmation'
      post 'set_status'
    end
    resources :print_request_actions
  end

  # Feeds and speeds iframes from Zoho
  get '/laser_settings', to: 'welcome#laser_settings'
  get '/cnc_settings', to: 'welcome#cnc_settings'

  # Legacy lending system from Zoho
  get '/lending', to: 'legacy_lending#index'
  get '/lending/search', to: 'legacy_lending#search'
  get '/lending/lend', to: 'legacy_lending#lend'
  get '/lending/return', to: 'legacy_lending#return'
  get '/lending/course_lend', to: 'legacy_lending#course_lend'
  get '/lending/student_purchase', to: 'legacy_lending#student_purchase'
  get '/lending/course_purchase', to: 'legacy_lending#course_purchase'
  get '/lending/cube_cartridge', to: 'legacy_lending#cube_cartridge'

end
