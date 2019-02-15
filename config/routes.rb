Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  as :user do
    get "/users/sign_up" => "devise/registrations#new", constraints: { subdomain: 'office' }
    post 'users' => 'devise/registrations#create', :as => 'user_registration', constraints: { subdomain: 'office' }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/affiliate_program' => 'affiliate_programs#index'
  get '/terms' => 'terms#index'
  get '/faq' => 'faq#index'
  get '/download' => 'downloads#index', as: :download
  get '/' => 'landing_page#index', as: :home
end
