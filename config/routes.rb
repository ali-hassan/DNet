Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  as :user do
    get "/users/sign_up" => "registrations#new", constraints: { subdomain: 'office' }
    post 'users' => 'registrations#create', :as => 'user_registration', constraints: { subdomain: 'office' }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :my_networks
  resources :verify_sponsor_users
  get '/affiliate_program' => 'affiliate_programs#index'
  get '/terms' => 'terms#index'
  get '/faq' => 'faq#index'
  get '/download' => 'downloads#index', as: :download
  get '/' => 'landing_page#index', as: :home
end
