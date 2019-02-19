Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # devise_for :users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  devise_for :users, skip: [:registrations, :sessions]

  as :user do
    get "/users/sign_up" => "registrations#new", constraints: { subdomain: 'office' }
    get "/users/sign_in" => "sessions#new", as: :new_user_session, constraints: { subdomain: 'office' }
    get "/users/sign_out" => "sessions#destroy", as: :delete_user_session, constraints: { subdomain: 'office' }
    post "/users/sign_in" => "sessions#create", as: :user_session, constraints: { subdomain: 'office' }
    post 'users' => 'registrations#create', :as => 'user_registration', constraints: { subdomain: 'office' }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :my_networks
  resources :verify_sponsor_users
  resources :buy_plans, only: [:index, :show, :create]
  resources :histories, only: [:index]
  resources :news, only: [:index]
  resources :trainings, only: [:index]
  resources :withdrawl_requests, only: [:index]
  resources :transactions, only: [:index]

  get '/affiliate_program' => 'affiliate_programs#index'
  get '/terms' => 'terms#index'
  get '/faq' => 'faq#index'
  get '/download' => 'downloads#index', as: :download
  get '/' => 'landing_page#index', as: :home
  get 'contact' => "landing_page#contact"
  post 'contact_us' => "landing_page#contact_us"
end
