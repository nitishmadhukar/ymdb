Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'movies#index'
  resources :movies, only: [:index, :show]
  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index, :show]
  	end
  end
end
