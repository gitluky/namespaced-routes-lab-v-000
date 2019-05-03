Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :artists do
    resources :songs, only: [:show, :index]
  end

  resources :songs

  namespace :admin do
    resources :preferences
  end
end
