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
  get '/lending/prepare', to: 'legacy_lending#item_prepare'
  get '/lending/lend', to: 'legacy_lending#item_lend'
  get '/lending/return', to: 'legacy_lending#item_return'
  get '/lending/renew(/:txid)(/:renewkey)', to: 'legacy_lending#item_renew'
  get '/lending/inventory', to: 'legacy_lending#item_inventory'
  get '/lending/reserves', to: 'legacy_lending#item_reserves'

  get '/lending/schedule/shifts', to: 'legacy_lending#schedule_shifts'
  get '/lending/schedule/deliveries', to: 'legacy_lending#schedule_deliveries'

  get '/sales', to: 'legacy_lending#sale_index'
  get '/sales/student', to: 'legacy_lending#sale_student'
  get '/sales/course', to: 'legacy_lending#sale_course'
  get '/sales/student/return', to: 'legacy_lending#sale_student_return'
  get '/sales/course/return', to: 'legacy_lending#sale_course_return'
  get '/sales/pricing', to: 'legacy_lending#sale_inventory'

  post '/lending/scan_input', to: 'legacy_lending#scan_input'

  # Physical Computing inventory
  get '/physcomp/inventory', to: 'physical_computing#inventory'

  # Tech Advisor pages
  get '/open/intake', to: 'tech_advisors#open_hours_intake'
  get '/open/print/ultimaker', to: 'tech_advisors#print_ultimaker'

  # Reservations and hours
  resources :schedule, param: :room, controller: 'room_schedule', only: [:index, :show]

  # Resource Requests
  get '/request', to: 'resource_requests#index'
  get '/request/lending', to: 'legacy_lending#item_request'
  get '/request/physcomp', to: 'resource_requests#request_physcomp_stock'
  get '/request/resource', to: 'resource_requests#request_resource'

end
