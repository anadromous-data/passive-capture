require "resque/server"
Rails.application.routes.draw do
	mount Resque::Server, :at => "/resque"
  
    root 'home#index'

    get 'about', to: 'home#about'
    get 'data', to: 'home#data'

    resources :dams, only: [:index, :show] do
  	  resources :fish_counts, only: [:index, :show]
    end

    resources :fish, only: [:index, :show] do
    end
end
