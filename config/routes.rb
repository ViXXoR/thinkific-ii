Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    #resources :users

    get '/current', to: 'users#current'
    get '/next', to: 'users#next'
    put '/current', to: 'users#reset'
    post '/register', to: 'authentication#register'
    post '/authenticate', to: 'authentication#authenticate'
  end
end
