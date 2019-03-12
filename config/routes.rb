require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
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
  with_options constraints: { subdomain: 'office' } do |subdomain_constraint|
    subdomain_constraint.resources :verify_sponsor_users
    subdomain_constraint.resources :buy_plans, only: [:index, :show, :create, :edit]
    subdomain_constraint.resources :upgrade_plans, only: [:index, :show, :create, :edit]
    subdomain_constraint.resources :histories, only: [:index, :show]
    subdomain_constraint.resources :news, only: [:index]
    subdomain_constraint.resources :trainings, only: [:index]
    subdomain_constraint.resources :withdrawl_requests, only: [:index]
    subdomain_constraint.resources :dashboard, only: [:index]
    subdomain_constraint.resources :system_credentials, only: [:index, :create]
    subdomain_constraint.resources :pay_with_bitcoins, only: [:show]
    subdomain_constraint.resources :financial_pins, only: [:new, :create]
    subdomain_constraint.resources :current_weekly_roi_to_cash_transfers, only: [:new, :create]
    subdomain_constraint.resource :pin_verify, only: [:show, :create]
    subdomain_constraint.resources :transactions, only: [:index, :create] do
      collection do
        get :cash_to_smart
      end
    end
    subdomain_constraint.resources :users do
      collection do
        get :me
        get :kyc
        get :system_password
      end
    end
    subdomain_constraint.resources :my_networks do
      collection do
        get :my_binary
        get :direct_referrals
      end
    end
  end
  get '/affiliate_program' => 'affiliate_programs#index'
  get '/terms' => 'terms#index'
  get '/faq' => 'faq#index'
  get '/download' => 'downloads#index', as: :download
  get '/' => 'landing_page#index', as: :home
  get 'contact' => "landing_page#contact"
  post 'contact_us' => "landing_page#contact_us"
  root to: "landing_page#index"
end
