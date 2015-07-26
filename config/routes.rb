Rails.application.routes.draw do
  
  root 'home#index'

  get 'about', to: 'home#about'
  get 'data', to: 'home#data'

  resources :dams, only: [:index, :show] do
  	resources :fish_counts, only: [:index, :show]
  end

end
