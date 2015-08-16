require "resque/server"
Rails.application.routes.draw do
	mount Resque::Server, :at => "/resque"
  
    root 'home#index'
    get 'about', to: 'home#about'

    resources :dams, only: [:index, :show] do
    	get 'count_data', to: 'dams#count_data'
  	  resources :fish_counts, only: [:index, :show]
    end

    resources :fish
end
