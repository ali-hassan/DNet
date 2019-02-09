Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/affiliate_program' => 'affiliate_programs#index'
  get '/' => 'landing_page#index', as: :home
end
