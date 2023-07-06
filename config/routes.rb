Rails.application.routes.draw do
  resources :viewing_users
  resources :viewing_parties

  namespace :movies do
      resources :results, only:[:index]
  end

  resources :movies

  namespace :users do
    resources :register, only:[:index, :show, :create]
  end

  resources :users, only:[:show] do
    resources :discover, only:[:index]
  end
  
  #   resources :dashboard, only: [:index]
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get "/", to: "application#landing", controller: [:user]
end
