Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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

end
