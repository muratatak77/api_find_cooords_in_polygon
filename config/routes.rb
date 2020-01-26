Rails.application.routes.draw do
  
  resources :geofences
  post 'find_by_coordinate', to: 'geofences#find_by_coordinate#'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
